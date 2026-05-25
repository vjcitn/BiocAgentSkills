# Prompt Test Suite: load-gene-from-gff-gtf (bundled GFF3)

Each prompt is sent independently to the model. The goal is to understand
how much guidance is needed to reach correct, idiomatic Bioconductor code.

All prompts expect the model to produce R code that loads the txdbmaker
bundled example file and extracts gene model features from it.

---

## P1 — Minimal / no context

```
Load a GFF file in R and show me the genes and exons.
```

Expected failure modes: uses rtracklayer instead of txdbmaker, doesn't produce
a TxDb, doesn't call exonsBy/transcriptsBy.

---

## P2 — Package hint only

```
Use the txdbmaker R package to load a GFF3 file and extract exons grouped by gene.
Use the bundled example file from the package.
```

Expected improvement: correct package, may miss `format=` argument or not call
`system.file()` correctly.

---

## P3 — Skill-aligned (mirrors the how-to structure)

```
Using txdbmaker's makeTxDbFromGFF, load the bundled GFF3 example file
(system.file("extdata", "GFF3_files", "a.gff3", package="txdbmaker"))
and show me:
1. Exons grouped by gene
2. Transcripts grouped by gene
3. CDS grouped by transcript
```

Expected result: close to reference implementation; should pass most checks.

---

## P4 — Full skill document as context (system prompt injection)

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
Load the txdbmaker bundled GFF3 example file and show me exons, transcripts,
and CDS grouped appropriately.
```

Expected result: highest fidelity — should match reference implementation
almost exactly.

---

## P5 — Adversarial / legacy trap

```
Use GenomicFeatures to load the txdbmaker bundled GFF3 file (a.gff3) as a TxDb.
Show exons grouped by gene.
```

This prompt names the older package intentionally. A skill-aware model should
still reach for `txdbmaker::makeTxDbFromGFF` (which is the current package,
even though `GenomicFeatures` re-exports a deprecated version).

Expected failure mode: calls `GenomicFeatures::makeTxDbFromGFF` (deprecated)
instead of `txdbmaker::makeTxDbFromGFF`.

---

## Scoring dimensions (per prompt)

| Dimension | Description |
|-----------|-------------|
| Runs      | Code executes without error |
| Package   | Uses `txdbmaker` (not deprecated `GenomicFeatures` path) |
| Format    | Passes `format=` argument correctly |
| Counts    | Gene/exon/tx counts match ground truth |
| Coords    | Named gene coordinates match ground truth |
| Grouping  | Uses `exonsBy`/`transcriptsBy` (not just `genes()`) |
| Concise   | No unnecessary steps or redundant library calls |
