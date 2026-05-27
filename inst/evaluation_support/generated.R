library(txdbmaker)

# Load the bundled GFF3 example file
gff_file <- system.file("extdata", "GFF3_files", "a.gff3", package = "txdbmaker")
txdb <- makeTxDbFromGFF(gff_file, format = "gff3")

# 1. Exons grouped by gene
cat("=== Exons grouped by gene ===\n")
exons_by_gene <- exonsBy(txdb, by = "gene")
exons_by_gene

# 2. Transcripts grouped by gene
cat("\n=== Transcripts grouped by gene ===\n")
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")
transcripts_by_gene

# 3. CDS grouped by transcript
cat("\n=== CDS grouped by transcript ===\n")
cds_by_tx <- cdsBy(txdb, by = "tx")
cds_by_tx
