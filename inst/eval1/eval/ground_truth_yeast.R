# Ground truth facts for Saccharomyces cerevisiae, Ensembl release 113
# Assembly: R64-1-1  |  Taxonomy ID: 4932
# Source URL: https://ftp.ensembl.org/pub/release-113/gff3/saccharomyces_cerevisiae/
#             Saccharomyces_cerevisiae.R64-1-1.113.gff3.gz
# Computed with txdbmaker 1.8.0 / GenomicFeatures on 2026-05-23
#
# Note: 91 exons in the GFF3 cannot be linked to a transcript and are silently
# dropped by makeTxDbFromGFF — this is expected for this release.

YEAST_GFF_URL <- paste0(
  "https://ftp.ensembl.org/pub/release-113/gff3/saccharomyces_cerevisiae/",
  "Saccharomyces_cerevisiae.R64-1-1.113.gff3.gz"
)

YEAST_FACTS <- list(

  # ---- build parameters ----
  organism    = "Saccharomyces cerevisiae",
  taxonomy_id = 4932L,
  ensembl_release = 113L,
  assembly    = "R64-1-1",

  # ---- corpus-level counts ----
  n_genes       = 7036L,
  n_transcripts = 7036L,
  n_exons       = 7416L,
  n_cds_groups  = 6600L,   # cdsBy(txdb, by="tx"); 436 tx lack CDS (ncRNA etc.)
  seqlevels     = c("I","II","III","IV","V","VI","VII","VIII",
                    "IX","X","XI","XII","XIII","XIV","XV","XVI","Mito"),

  # ---- YAL001C (TFC3): 2-exon, chrI, minus-strand ----
  YAL001C = list(
    id          = "YAL001C",
    seqname     = "I",
    start       = 147594L,
    end         = 151166L,
    strand      = "-",
    n_exons     = 2L,
    exon_starts = c(147594L, 151097L),
    exon_ends   = c(151006L, 151166L),
    n_tx        = 1L,
    tx_name     = "YAL001C_mRNA"
  ),

  # ---- YAL002W (VPS8): 1-exon, chrI, plus-strand ----
  YAL002W = list(
    id          = "YAL002W",
    seqname     = "I",
    start       = 143707L,
    end         = 147531L,
    strand      = "+",
    n_exons     = 1L,
    exon_starts = 143707L,
    exon_ends   = 147531L,
    n_tx        = 1L,
    tx_name     = "YAL002W_mRNA"
  ),

  # ---- YAL003W (EFB1): 2-exon, chrI, plus-strand ----
  YAL003W = list(
    id          = "YAL003W",
    seqname     = "I",
    start       = 142174L,
    end         = 143160L,
    strand      = "+",
    n_exons     = 2L,
    exon_starts = c(142174L, 142620L),
    exon_ends   = c(142253L, 143160L),
    n_tx        = 1L,
    tx_name     = "YAL003W_mRNA"
  ),

  # ---- YFL039C (ACT1, actin): 2-exon, chrVI, minus-strand ----
  # Classic intron-containing gene; 2 CDS segments
  YFL039C = list(
    id          = "YFL039C",
    seqname     = "VI",
    start       = 53260L,
    end         = 54696L,
    strand      = "-",
    n_exons     = 2L,
    exon_starts = c(53260L, 54687L),
    exon_ends   = c(54377L, 54696L),
    n_tx        = 1L,
    tx_name     = "YFL039C_mRNA",
    n_cds       = 2L,
    cds_starts  = c(54687L, 53260L),   # ordered by tx_id lookup; minus-strand
    cds_ends    = c(54696L, 54377L)
  ),

  # ---- Q0045 (COX1): 8-exon, Mito, plus-strand ----
  # Mitochondrial gene; most exons of any gene in this annotation
  Q0045 = list(
    id          = "Q0045",
    seqname     = "Mito",
    start       = 13818L,
    end         = 26701L,
    strand      = "+",
    n_exons     = 8L,
    exon_starts = c(13818L, 16435L, 18954L, 20508L, 21995L, 23612L, 25318L, 26229L),
    exon_ends   = c(13986L, 16470L, 18991L, 20984L, 22246L, 23746L, 25342L, 26701L),
    n_tx        = 1L,
    tx_name     = "Q0045_mRNA"
  )
)
