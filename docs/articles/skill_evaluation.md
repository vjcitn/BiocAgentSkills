<div id="main" class="col-md-9" role="main">

# Evaluating Bioconductor Agent Skills

<div class="section level2">

## Introduction

The `BiocAgentSkills` package ships a collection of **how-to skill
documents** that teach AI agents (Claude Code, GitHub Copilot, Gemini)
Bioconductor conventions and multi-step workflows. The value of a skill
document depends on the code it elicits, which itself will depend on the
user’s prompt and the model in use. If a model ignores the document,
uses a deprecated function, or produces code that produces wrong
answers, the skill has failed.

This vignette describes the **evaluation framework** stored under
`inst/eval1/eval/`. The framework was developed for the
`load-gene-from-gff-gtf` skill — a how-to guide for importing GFF3/GTF
annotation files as Bioconductor `TxDb` objects — and is designed to be
reusable for other skills.

The evaluation framework answers two questions:

1.  **Does the generated code follow the skill?** (static analysis)
2.  **Does it produce correct results?** (dynamic execution against
    ground truth)

An optional third path uses an LLM as judge for qualitative scoring.

</div>

<div class="section level2">

## The Skill Being Evaluated

The `load-gene-from-gff-gtf` skill (stored in
`inst/eval1/how-tos/load-gene-from-gff-gtf.md`) teaches agents to:

-   Load the `txdbmaker` package (not the deprecated `GenomicFeatures`
    path)
-   Call `makeTxDbFromGFF()` with an explicit `format =` argument
-   Extract gene model features with `exonsBy()`, `transcriptsBy()`, and
    `cdsBy()`

The reference implementation from the skill document is:

<div id="cb1" class="sourceCode">

``` r
library(txdbmaker)

gff_file <- system.file("extdata", "GFF3_files", "a.gff3", package = "txdbmaker")
txdb <- makeTxDbFromGFF(gff_file, format = "gff3")

exonsBy(txdb, by = "gene")
transcriptsBy(txdb, by = "gene")
cdsBy(txdb, by = "tx")
```

</div>

</div>

<div class="section level2">

## Evaluation Architecture

The `evaluation_support` folder contains three kinds of files:

| File                         | Role                                                                      |
|------------------------------|---------------------------------------------------------------------------|
| `ground_truth_bundled.R`     | Hard-coded expected counts and coordinates for the txdbmaker bundled GFF3 |
| `check_txdb.R`               | Shared correctness checker: runs a TxDb through a battery of assertions   |
| `simple_eval_bundled.R`      | Full evaluator for the bundled GFF3 (static + dynamic)                    |
| `prompts/bundled_prompts.md` | Prompt ladder (P1–P5) for the bundled scenario                            |

<div class="section level3">

### Two Test Scenarios

<div class="section level4">

#### Bundled GFF3 (offline, no download)

The `txdbmaker` package ships a small example file
`extdata/GFF3_files/a.gff3` — a partial annotation for *Solanum
lycopersicum* (tomato), chromosome SL2.40ch00 only. This scenario
requires no network access and runs quickly (&lt; 30 s on a laptop).

Ground truth (`BUNDLED_FACTS`):

-   **488** genes, **488** transcripts, **1 268** exons, **488** CDS
    groups
-   Single seqlevel `SL2.40ch00`
-   4 named genes with exact coordinate and exon-count checks

</div>

<div class="section level4">

#### Yeast GFF3 (real organism, requires download) \[NOT AVAILABLE IN FIRST DRAFT OF BiocAgentSkills\]

The second scenario uses the *Saccharomyces cerevisiae* Ensembl release
113 GFF3 (R64-1-1 assembly). The file is bundled in the package at
`inst/eval1/eval/data/Saccharomyces_cerevisiae.R64-1-1.113.gff3.gz` to
make evaluation reproducible without requiring a live FTP connection.

Ground truth (`YEAST_FACTS`):

-   **7 036** genes, **7 036** transcripts, **7 416** exons, **6 600**
    CDS groups
-   17 seqlevels (chromosomes I–XVI plus Mito)
-   5 named genes: YAL001C (TFC3, 2-exon, minus-strand), YAL002W (VPS8,
    1-exon), YAL003W (EFB1, 2-exon), YFL039C (ACT1, intron-containing),
    Q0045 (COX1, 8-exon mitochondrial)

The yeast scenario tests more of the skill’s surface area because it
requires the organism name and taxonomy ID metadata arguments.

</div>

</div>

</div>

<div class="section level2">

## Running an Evaluation

See the README.md under `inst/evaluation_support`.

The returned `result` list contains:

| Field          | Content                                             |
|----------------|-----------------------------------------------------|
| `$pass`        | `TRUE` if all checks pass                           |
| `$static`      | data.frame of static (code-text) checks             |
| `$correctness` | data.frame of dynamic (TxDb object) checks          |
| `$combined`    | `rbind` of both                                     |
| `$run_error`   | Error message if execution failed, otherwise `NULL` |

<div class="section level3">

### Step 3 — Inspect results

<div id="cb2" class="sourceCode">

``` r
print(result$combined)
```

</div>

A passing run looks like:

                      check status detail
            uses txdbmaker   PASS
      avoids deprecated path PASS
                 format= arg PASS
                    exonsBy  PASS
              transcriptsBy  PASS
                      cdsBy  PASS
                    is TxDb  PASS
                 gene count  PASS  488 (expected 488)
           transcript count  PASS  488 (expected 488)
                 exon count  PASS  1268 (expected 1268)
                 CDS groups  PASS  488 (expected 488)
                  seqlevels  PASS
               gene1 start   PASS  16437
               ...

</div>

</div>

<div class="section level2">

## The Prompt Ladder

A key design principle is that prompts are tested at multiple levels of
specificity. This “ladder” reveals how much guidance a model needs to
produce correct, idiomatic code.

<div class="section level3">

### Bundled prompts (P1–P5)

| Prompt                | Framing                                                                          | Expected failure mode                                  |
|-----------------------|----------------------------------------------------------------------------------|--------------------------------------------------------|
| **P1** Minimal        | “Load a GFF file in R and show me the genes and exons.”                          | Uses `rtracklayer` instead of `txdbmaker`; no TxDb     |
| **P2** Package hint   | “Use txdbmaker to load a GFF3 file…”                                             | Correct package, may miss `format=` or `system.file()` |
| **P3** Skill-aligned  | Names the function, the bundled file path, and asks for all three grouping calls | Near-reference; should pass most checks                |
| **P4** Full skill doc | Skill how-to injected as system prompt                                           | Highest fidelity; should match reference exactly       |
| **P5** Adversarial    | Asks for `GenomicFeatures::makeTxDbFromGFF` explicitly                           | Tests whether skill overrides legacy framing           |

</div>

<div class="section level3">

### Yeast prompts (P1–P6)

The yeast ladder adds two scenarios not present in the bundled suite:

-   **P5 Remote URL**: Asks the model to load directly from the Ensembl
    FTP URL, testing the skill’s note that `makeTxDbFromGFF()` accepts
    remote paths.
-   **P6 Adversarial**: Same legacy trap as bundled P5, but with a real
    file path.

</div>

</div>

<div class="section level2">

## Static vs Dynamic Checks

<div class="section level3">

### Static checks (code text analysis)

Six checks are applied by regex to the generated code string before
execution:

| Check                    | What it tests                                                      |
|--------------------------|--------------------------------------------------------------------|
| `uses txdbmaker`         | `library(txdbmaker)` or `txdbmaker::` present                      |
| `avoids deprecated path` | Does not call `GenomicFeatures::makeTxDbFromGFF` without txdbmaker |
| `format= arg`            | Passes `format = "gff3"`, `"gtf"`, or `"auto"`                     |
| `exonsBy`                | Calls `exonsBy()`                                                  |
| `transcriptsBy`          | Calls `transcriptsBy()`                                            |
| `cdsBy`                  | Calls `cdsBy()`                                                    |

Static checks are fast, require no installed packages, and detect the
most common failure modes even when code cannot be executed.

</div>

<div class="section level3">

### Dynamic checks (correctness)

The evaluator executes the generated code in a fresh environment, finds
any `TxDb` variable, and passes it to `check_txdb()`. Correctness checks
include:

-   `is TxDb` — class guard; all downstream checks skip if this fails
-   Corpus-level counts: genes, transcripts, exons, CDS groups
-   Seqlevel names (order-insensitive comparison)
-   Per-gene coordinate and exon-count assertions for named landmark
    genes

The yeast evaluator adds per-gene checks for strand, transcript name,
and CDS count for ACT1 (YFL039C).

</div>

</div>

<div class="section level2">

## LLM-as-Judge Scoring

For qualitative dimensions not captured by execution (conciseness,
clarity, absence of unnecessary steps), `eval/judge_prompt.md` provides
a template for Claude-as-judge scoring.

The judge scores six dimensions:

| Dimension      | Description                                            |
|----------------|--------------------------------------------------------|
| `pkg_correct`  | Uses `txdbmaker::makeTxDbFromGFF`, not deprecated path |
| `format_arg`   | Passes `format =` explicitly                           |
| `file_path`    | Uses `system.file()` or a valid path                   |
| `extracts_all` | Calls all three grouping functions                     |
| `conciseness`  | No redundant steps or unnecessary library loads        |
| `runnable`     | Code would execute without errors                      |

Each dimension is scored PASS (2), PARTIAL (1), or FAIL (0). Maximum
score is 12. Interpretation:

| Score  | Meaning                               |
|--------|---------------------------------------|
| ≥ 10   | Skill document is being followed well |
| 6–9    | Prompt needs more specificity         |
| &lt; 6 | Skill is not being invoked at all     |

</div>

<div class="section level2">

## Extending to Other Skills

To build a similar evaluation for a different Bioconductor how-to skill:

1.  **Define ground truth** — run the reference implementation and
    record corpus-level counts and landmark-feature coordinates in a
    `ground_truth_*.R` file.
2.  **Write a checker** — a function that accepts a result object and a
    facts list, and records PASS/FAIL for each assertion.
3.  **Build a prompt ladder** — at minimum: minimal prompt, package-hint
    prompt, skill-aligned prompt, and an adversarial prompt that tries
    to trigger the most common failure mode for the domain.
4.  **Assemble an evaluator** — combine static code analysis with
    dynamic execution, following the pattern in `run_eval_bundled.R`.

The two-level structure (static + dynamic) is worth preserving: static
checks catch the most common problems cheaply, while dynamic checks
catch subtle semantic errors that regex cannot.

</div>

<div class="section level2">

## Session Info

<div id="cb4" class="sourceCode">

``` r
sessionInfo()
#> R version 4.6.0 beta (2026-04-12 r89882)
#> Platform: aarch64-apple-darwin23
#> Running under: macOS Sequoia 15.7.4
#> 
#> Matrix products: default
#> BLAS:   /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRblas.0.dylib 
#> LAPACK: /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1
#> 
#> locale:
#> [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#> 
#> time zone: Europe/Rome
#> tzcode source: internal
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] BiocStyle_2.40.0
#> 
#> loaded via a namespace (and not attached):
#>  [1] digest_0.6.39       desc_1.4.3          R6_2.6.1           
#>  [4] bookdown_0.46       fastmap_1.2.0       xfun_0.57          
#>  [7] cachem_1.1.0        knitr_1.51          htmltools_0.5.9    
#> [10] rmarkdown_2.31      lifecycle_1.0.5     cli_3.6.6          
#> [13] sass_0.4.10         pkgdown_2.2.0       textshaping_1.0.5  
#> [16] jquerylib_0.1.4     systemfonts_1.3.2   compiler_4.6.0     
#> [19] tools_4.6.0         ragg_1.5.2          bslib_0.10.0       
#> [22] evaluate_1.0.5      yaml_2.3.12         BiocManager_1.30.27
#> [25] otel_0.2.0          jsonlite_2.0.0      rlang_1.2.0        
#> [28] fs_2.1.0            htmlwidgets_1.6.4
```

</div>

</div>

</div>
