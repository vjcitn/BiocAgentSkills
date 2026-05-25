# Prompt Test Suite: load-gene-from-gff-gtf (S. cerevisiae Ensembl r113)

GFF3 source: https://ftp.ensembl.org/pub/release-113/gff3/saccharomyces_cerevisiae/
             Saccharomyces_cerevisiae.R64-1-1.113.gff3.gz

All prompts reference a local path or the URL above. Replace `<LOCAL_PATH>`
with the actual path to the downloaded file.

---

## P1 — Minimal / no context

```
Load a GFF file for yeast in R and show me the genes and exons.
Use this file: <LOCAL_PATH>
```

---

## P2 — Package hint only

```
Use txdbmaker to load this S. cerevisiae GFF3 file in R and extract
exons grouped by gene:
  <LOCAL_PATH>
```

---

## P3 — Skill-aligned (mirrors the how-to structure)

```
Using txdbmaker's makeTxDbFromGFF, load this S. cerevisiae GFF3 file:
  <LOCAL_PATH>

Set organism="Saccharomyces cerevisiae" and taxonomyId=4932.
Show me:
1. Exons grouped by gene
2. Transcripts grouped by gene
3. CDS grouped by transcript
```

---

## P4 — Full skill document as context

*System prompt / preamble:*

```
You are an expert Bioconductor developer. Use the following how-to guide
when answering questions about loading gene models:

---
[PASTE FULL CONTENT OF how-tos/load-gene-from-gff-gtf.md HERE]
---
```

*User message:*

```
Load this S. cerevisiae GFF3 file using Bioconductor and show exons,
transcripts, and CDS grouped appropriately.
Set organism="Saccharomyces cerevisiae" and taxonomyId=4932.
File: <LOCAL_PATH>
```

---

## P5 — Remote URL (tests skill's URL hint)

```
Use txdbmaker to load the S. cerevisiae gene annotation directly from
Ensembl release 113 and show exons grouped by gene:
  https://ftp.ensembl.org/pub/release-113/gff3/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.113.gff3.gz
```

This tests whether the model uses the remote URL feature mentioned in the
skill's Notes section.

---

## P6 — Adversarial / legacy trap

```
Use GenomicFeatures to load this yeast GFF3 file as a TxDb, then show
exons grouped by gene:
  <LOCAL_PATH>
```

---

## Scoring dimensions (same as bundled suite)

| Dimension    | Description |
|--------------|-------------|
| Runs         | Code executes without error |
| Package      | Uses `txdbmaker` (not deprecated `GenomicFeatures` path) |
| Format       | Passes `format=` argument correctly |
| Counts       | Gene/exon/tx counts match ground truth (7036/7416/7036) |
| Coords       | Named gene coordinates match (YAL001C, YFL039C/ACT1, Q0045) |
| Grouping     | Uses `exonsBy`/`transcriptsBy` not just `genes()` |
| Organism     | Sets `organism=` and `taxonomyId=` metadata |

The organism/taxonomyId dimension is new relative to the bundled suite —
it reflects the skill gap where the how-to document does not show these args.
