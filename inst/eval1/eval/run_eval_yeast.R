# run_eval_yeast.R
#
# Evaluate R code against the S. cerevisiae Ensembl R64-1-1 r113 ground truth.
#
# Usage (shell, from project root):
#   Rscript eval/run_eval_yeast.R path/to/generated_code.R
#
# Usage (interactive):
#   source("eval/run_eval_yeast.R")
#   result <- eval_code_file_yeast("path/to/generated_code.R")
#   result <- eval_code_string_yeast('library(txdbmaker); ...')

# ---- path resolution ----
.eval_dir <- tryCatch(dirname(normalizePath(sys.frames()[[1]]$ofile)), error = function(e) "eval")
source(file.path(.eval_dir, "ground_truth_yeast.R"))

# ---- static analysis helpers (shared with bundled evaluator) ----
.check_package_usage <- function(code) {
  uses_txdbmaker  <- grepl("library\\(txdbmaker\\)|require\\(txdbmaker\\)|txdbmaker::", code)
  uses_deprecated <- grepl("GenomicFeatures::makeTxDbFromGFF", code) && !uses_txdbmaker
  list(uses_txdbmaker = uses_txdbmaker, uses_deprecated_path = uses_deprecated)
}
.check_format_arg <- function(code) {
  grepl('format\\s*=\\s*["\']gff3["\']|format\\s*=\\s*["\']gtf["\']|format\\s*=\\s*["\']auto["\']',
        code, ignore.case = TRUE)
}
.check_grouping_fns <- function(code) {
  list(exonsBy       = grepl("exonsBy",       code),
       transcriptsBy = grepl("transcriptsBy", code),
       cdsBy         = grepl("cdsBy",         code))
}

# ---- correctness checker ----
check_txdb_yeast <- function(txdb, facts = YEAST_FACTS) {
  library(GenomicFeatures)
  results <- list()
  .rec <- function(check, pass, detail = "") {
    results[[length(results) + 1L]] <<- data.frame(
      check  = check,
      status = if (pass) "PASS" else "FAIL",
      detail = detail,
      stringsAsFactors = FALSE
    )
  }
  .eq <- function(a, b) isTRUE(all.equal(a, b))

  # ---- is TxDb ----
  .rec("is TxDb", is(txdb, "TxDb"))
  if (!is(txdb, "TxDb"))
    return(list(pass = FALSE, results = do.call(rbind, results)))

  # ---- corpus counts ----
  g   <- genes(txdb)
  tx  <- transcripts(txdb)
  ex  <- exons(txdb)
  cbt <- cdsBy(txdb, by = "tx")
  .rec("gene count",       length(g)   == facts$n_genes,
       sprintf("%d (expected %d)", length(g),   facts$n_genes))
  .rec("transcript count", length(tx)  == facts$n_transcripts,
       sprintf("%d (expected %d)", length(tx),  facts$n_transcripts))
  .rec("exon count",       length(ex)  == facts$n_exons,
       sprintf("%d (expected %d)", length(ex),  facts$n_exons))
  .rec("CDS groups",       length(cbt) == facts$n_cds_groups,
       sprintf("%d (expected %d)", length(cbt), facts$n_cds_groups))

  # ---- seqlevels (order-insensitive) ----
  .rec("seqlevels", .eq(sort(seqlevels(txdb)), sort(facts$seqlevels)),
       paste(sort(seqlevels(txdb)), collapse = ","))

  # ---- per-gene checks ----
  ebg <- exonsBy(txdb, by = "gene")
  tbg <- transcriptsBy(txdb, by = "gene")

  for (gf in list(facts$YAL001C, facts$YAL002W, facts$YAL003W,
                  facts$YFL039C, facts$Q0045)) {
    nm  <- gf$id
    pfx <- nm

    # gene present
    if (!nm %in% names(g)) {
      .rec(paste0(pfx, " found"), FALSE, paste(nm, "not in genes()"))
      next
    }
    gi <- g[nm]
    .rec(paste0(pfx, " seqname"), as.character(seqnames(gi)) == gf$seqname, as.character(seqnames(gi)))
    .rec(paste0(pfx, " start"),   start(gi) == gf$start, as.character(start(gi)))
    .rec(paste0(pfx, " end"),     end(gi)   == gf$end,   as.character(end(gi)))
    .rec(paste0(pfx, " strand"),  as.character(strand(gi)) == gf$strand, as.character(strand(gi)))

    # exons
    if (nm %in% names(ebg)) {
      exs <- ebg[[nm]]
      .rec(paste0(pfx, " exon count"), length(exs) == gf$n_exons,
           sprintf("%d (expected %d)", length(exs), gf$n_exons))
      if (!is.null(gf$exon_starts)) {
        .rec(paste0(pfx, " exon starts"), .eq(sort(start(exs)), sort(gf$exon_starts)),
             paste(sort(start(exs)), collapse = ","))
        .rec(paste0(pfx, " exon ends"),   .eq(sort(end(exs)),   sort(gf$exon_ends)),
             paste(sort(end(exs)), collapse = ","))
      }
    } else {
      .rec(paste0(pfx, " in exonsBy"), FALSE, paste(nm, "not in exonsBy"))
    }

    # transcript name
    if (nm %in% names(tbg)) {
      txs <- tbg[[nm]]
      .rec(paste0(pfx, " tx count"),  length(txs) == gf$n_tx, as.character(length(txs)))
      .rec(paste0(pfx, " tx name"),   txs$tx_name[1L] == gf$tx_name, txs$tx_name[1L])
    } else {
      .rec(paste0(pfx, " in transcriptsBy"), FALSE, paste(nm, "not in transcriptsBy"))
    }

    # CDS (only for YFL039C which has explicit CDS ground truth)
    if (!is.null(gf$n_cds) && nm %in% names(tbg)) {
      tx_id_val <- transcripts(txdb)$tx_id[transcripts(txdb)$tx_name == gf$tx_name]
      key       <- as.character(tx_id_val)
      if (length(key) == 1L && key %in% names(cbt)) {
        cds <- cbt[[key]]
        .rec(paste0(pfx, " CDS count"), length(cds) == gf$n_cds,
             sprintf("%d (expected %d)", length(cds), gf$n_cds))
      } else {
        .rec(paste0(pfx, " CDS found"), FALSE, "tx_id not in cdsBy result")
      }
    }
  }

  tbl  <- do.call(rbind, results)
  list(pass = all(tbl$status == "PASS"), results = tbl)
}

# ---- full evaluator ----
eval_code_string_yeast <- function(code, verbose = TRUE) {
  env <- new.env(parent = globalenv())
  run_error <- NULL; txdb <- NULL

  withCallingHandlers(
    tryCatch(eval(parse(text = code), envir = env),
             error = function(e) { run_error <<- conditionMessage(e) }),
    message = function(m) invokeRestart("muffleMessage"),
    warning = function(w) invokeRestart("muffleWarning")
  )

  if (is.null(run_error)) {
    all_vars  <- ls(env)
    txdb_vars <- if (length(all_vars) == 0L) character(0L) else
                   all_vars[vapply(all_vars, function(v) is(get(v, envir = env), "TxDb"), logical(1L))]
    if (length(txdb_vars) > 0L) txdb <- get(txdb_vars[1L], envir = env)
  }

  # static
  pkg      <- .check_package_usage(code)
  fmt_ok   <- .check_format_arg(code)
  grouping <- .check_grouping_fns(code)
  static   <- data.frame(
    check  = c("uses txdbmaker", "avoids deprecated path", "format= arg",
               "exonsBy", "transcriptsBy", "cdsBy"),
    status = c(if (pkg$uses_txdbmaker)        "PASS" else "FAIL",
               if (!pkg$uses_deprecated_path)  "PASS" else "FAIL",
               if (fmt_ok)                     "PASS" else "FAIL",
               if (grouping$exonsBy)            "PASS" else "FAIL",
               if (grouping$transcriptsBy)      "PASS" else "FAIL",
               if (grouping$cdsBy)              "PASS" else "FAIL"),
    detail = rep("", 6L),
    stringsAsFactors = FALSE
  )

  # correctness
  correctness <- if (!is.null(txdb)) {
    check_txdb_yeast(txdb)
  } else {
    list(pass = FALSE,
         results = data.frame(check = "TxDb found", status = "FAIL",
                              detail = if (is.null(run_error)) "no TxDb variable" else run_error,
                              stringsAsFactors = FALSE))
  }

  combined <- rbind(static, correctness$results)
  pass_all <- all(combined$status == "PASS")

  if (verbose) {
    cat("\n=== Static checks ===\n")
    print(static, row.names = FALSE)
    cat("\n=== Correctness checks ===\n")
    print(correctness$results, row.names = FALSE)
    cat(sprintf("\nOverall: %s  (%d/%d checks passed)\n",
                if (pass_all) "PASS" else "FAIL",
                sum(combined$status == "PASS"), nrow(combined)))
  }

  invisible(list(pass = pass_all, static = static, correctness = correctness$results,
                 combined = combined, run_error = run_error))
}

eval_code_file_yeast <- function(path, verbose = TRUE) {
  if (!file.exists(path)) stop("File not found: ", path)
  eval_code_string_yeast(paste(readLines(path), collapse = "\n"), verbose = verbose)
}

# ---- CLI ----
if (!interactive() && sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) == 0L) {
    cat("Usage: Rscript eval/run_eval_yeast.R <generated_code.R>\n")
    quit(status = 1L)
  }
  result <- eval_code_file_yeast(args[1L])
  quit(status = if (result$pass) 0L else 1L)
}
