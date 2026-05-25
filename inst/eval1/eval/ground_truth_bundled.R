# Ground truth facts for the txdbmaker bundled GFF3 (a.gff3)
# Source: extdata/GFF3_files/a.gff3 in txdbmaker package
# Organism: Solanum lycopersicum (tomato), partial — chromosome SL2.40ch00 only
# These values were computed from txdbmaker 1.8.0 / GenomicFeatures on 2026-05-23

BUNDLED_FACTS <- list(

  # ---- corpus-level counts ----
  n_genes       = 488L,
  n_transcripts = 488L,
  n_exons       = 1268L,
  n_cds_groups  = 488L,   # cdsBy(txdb, by="tx")
  seqlevels     = "SL2.40ch00",

  # ---- gene 1: 2-exon, plus-strand ----
  gene1 = list(
    id           = "Solyc00g005000.2",
    seqname      = "SL2.40ch00",
    start        = 16437L,
    end          = 18189L,
    strand       = "+",
    n_exons      = 2L,
    exon_starts  = c(16437L, 17336L),
    exon_ends    = c(17275L, 18189L),
    n_tx         = 1L,
    tx_name      = "Solyc00g005000.2.1",
    cds_starts   = c(16480L, 17336L),
    cds_ends     = c(17275L, 17940L)
  ),

  # ---- gene 2: 3-exon, plus-strand ----
  gene3ex = list(
    id          = "Solyc00g005020.1",
    n_exons     = 3L,
    exon_starts = c(68062L, 68344L, 68654L),
    exon_ends   = c(68211L, 68568L, 68764L)
  ),

  # ---- gene 3: 4-exon, plus-strand ----
  gene4ex = list(
    id      = "Solyc00g005040.2",
    n_exons = 4L
  ),

  # ---- gene 4: 5-exon, minus-strand ----
  gene5ex = list(
    id      = "Solyc00g005050.2",
    n_exons = 5L,
    strand  = "-"
  )
)
