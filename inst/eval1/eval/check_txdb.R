# check_txdb(txdb, facts) -- assert a TxDb object matches a BUNDLED_FACTS list.
# Returns a list: $pass (logical), $results (data.frame of check/status/detail rows).
#
# Usage:
#   source("eval/ground_truth_bundled.R")
#   source("eval/check_txdb.R")
#   res <- check_txdb(txdb, BUNDLED_FACTS)
#   print(res$results)

check_txdb <- function(txdb, facts) {
  library(GenomicFeatures)

  results <- list()

  .record <- function(check, pass, detail = "") {
    results[[length(results) + 1L]] <<- data.frame(
      check  = check,
      status = if (pass) "PASS" else "FAIL",
      detail = detail,
      stringsAsFactors = FALSE
    )
  }

  .eq <- function(a, b) isTRUE(all.equal(a, b))

  # ---- is it even a TxDb? ----
  .record("is TxDb", is(txdb, "TxDb"))

  if (!is(txdb, "TxDb")) {
    return(list(pass = FALSE, results = do.call(rbind, results)))
  }

  # ---- corpus counts ----
  n_g  <- length(genes(txdb))
  n_tx <- length(transcripts(txdb))
  n_ex <- length(exons(txdb))
  cbt  <- cdsBy(txdb, by = "tx")

  .record("gene count",       n_g  == facts$n_genes,       sprintf("%d (expected %d)", n_g,  facts$n_genes))
  .record("transcript count", n_tx == facts$n_transcripts, sprintf("%d (expected %d)", n_tx, facts$n_transcripts))
  .record("exon count",       n_ex == facts$n_exons,       sprintf("%d (expected %d)", n_ex, facts$n_exons))
  .record("CDS groups",       length(cbt) == facts$n_cds_groups,
          sprintf("%d (expected %d)", length(cbt), facts$n_cds_groups))
  .record("seqlevels",        .eq(seqlevels(txdb), facts$seqlevels),
          sprintf("'%s' (expected '%s')", paste(seqlevels(txdb), collapse=","), facts$seqlevels))

  # ---- gene 1 coordinates ----
  g1f <- facts$gene1
  g   <- genes(txdb)
  g1  <- g[names(g) == g1f$id]
  if (length(g1) == 1L) {
    .record("gene1 start",  start(g1) == g1f$start,  sprintf("%d", start(g1)))
    .record("gene1 end",    end(g1)   == g1f$end,    sprintf("%d", end(g1)))
    .record("gene1 strand", as.character(strand(g1)) == g1f$strand, as.character(strand(g1)))
  } else {
    .record("gene1 found", FALSE, paste("gene", g1f$id, "not found"))
  }

  # ---- gene 1 exons ----
  ebg <- exonsBy(txdb, by = "gene")
  if (g1f$id %in% names(ebg)) {
    ex1 <- ebg[[g1f$id]]
    .record("gene1 exon count",   length(ex1)    == g1f$n_exons,     sprintf("%d", length(ex1)))
    .record("gene1 exon1 start",  start(ex1)[1L] == g1f$exon_starts[1L], sprintf("%d", start(ex1)[1L]))
    .record("gene1 exon1 end",    end(ex1)[1L]   == g1f$exon_ends[1L],   sprintf("%d", end(ex1)[1L]))
    .record("gene1 exon2 start",  start(ex1)[2L] == g1f$exon_starts[2L], sprintf("%d", start(ex1)[2L]))
    .record("gene1 exon2 end",    end(ex1)[2L]   == g1f$exon_ends[2L],   sprintf("%d", end(ex1)[2L]))
  } else {
    .record("gene1 in exonsBy", FALSE, paste(g1f$id, "not in exonsBy result"))
  }

  # ---- gene 1 transcripts ----
  tbg <- transcriptsBy(txdb, by = "gene")
  if (g1f$id %in% names(tbg)) {
    tx1 <- tbg[[g1f$id]]
    .record("gene1 tx count",   length(tx1) == g1f$n_tx, sprintf("%d", length(tx1)))
    .record("gene1 tx name",    tx1$tx_name[1L] == g1f$tx_name, tx1$tx_name[1L])
  } else {
    .record("gene1 in transcriptsBy", FALSE, paste(g1f$id, "not in transcriptsBy result"))
  }

  # ---- named multi-exon genes ----
  for (nm in c("gene3ex", "gene4ex", "gene5ex")) {
    gf <- facts[[nm]]
    if (gf$id %in% names(ebg)) {
      ex <- ebg[[gf$id]]
      .record(paste0(nm, " exon count"), length(ex) == gf$n_exons,
              sprintf("%d (expected %d)", length(ex), gf$n_exons))
      if (!is.null(gf$strand)) {
        gi <- g[names(g) == gf$id]
        .record(paste0(nm, " strand"), as.character(strand(gi)) == gf$strand,
                as.character(strand(gi)))
      }
      if (!is.null(gf$exon_starts)) {
        .record(paste0(nm, " exon starts"),
                .eq(sort(start(ex)), sort(gf$exon_starts)),
                paste(sort(start(ex)), collapse=","))
      }
    } else {
      .record(paste0(nm, " found"), FALSE, paste(gf$id, "not found"))
    }
  }

  tbl  <- do.call(rbind, results)
  pass <- all(tbl$status == "PASS")
  list(pass = pass, results = tbl)
}
