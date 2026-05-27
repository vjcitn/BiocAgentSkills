<div id="main" class="col-md-9" role="main">

# BiocAgentSkills – packaging and documenting resources for AI agent training and use with Bioconductor

<div class="section level1">

<div class="section level2">

## Main purpose of the R package approach

Bioconductor has a long history of producing self-describing data
structures and self-documenting software modules in R packages. The R
package framework structures code, data, metadata, and documentation in
ways that support computational assessment and verification. This
particular package represents an experiment in the use of R package
structure and function to manage content of agent skills documents.

We use the `inst/` folder to manage skills and evaluations. See the
BiocAgentSkills vignette for more details.

</div>

<div class="section level2">

## Key online resources

Ultimately this package will not contain skill documents, but will
provide verifiable references to relevant skills. Principal examples
include

-   [Waldronlab skills](https://github.com/waldronlab/ai-agent-skills)
-   Sean Davis’ [Bioconductor task
    skills](https://github.com/Bioconductor/ai-agent-skills/blob/devel/skills/bioc-howto/SKILL.md)

In the initial development of this package, Claude was asked to create
an evaluation framework for one of the Bioconductor task skills. Thus
there are “frozen” versions of the skills used for this process under
`/inst/eval1`.

A general introduction to agentic coding is
[available](https://github.com/seandavi/agentic-coding-intro).

</div>

<div class="section level2">

## Design Philosophy of these Skills

<div class="section level3">

### Workflow Orchestration vs. Code-Centric Snippets

Many AI skill repositories are code snippet libraries, providing the AI
with advanced copy-paste templates to execute a single task. While fast,
this **Code-Centric approach** is brittle, lacks autonomy, and misses
the “why” behind the code.

These skills instead provide **Workflow/Process Orchestration**. They
treat the AI like a junior developer given a Standard Operating
Procedure (SOP). Rather than just providing raw syntax, a skill defines
the *intent*, the *multi-step workflow*, and the *domain knowledge*
required.

For example, our code coverage skill doesn’t just provide the command to
run `covr`; it orchestrates a workflow: run the coverage, summarize the
gaps, classify testing needs (Normal Use, Edge Cases, Error Handling,
Correctness), and proactively write new test cases based on those
criteria. This approach enables high autonomy, encourages the AI to
follow the intent of the process orchestration, and allows it to adapt
to different project structures using its general reasoning
capabilities.

</div>

<div class="section level3">

### Illustration of “prompt ladder”

There are levels of sophistication in prompting the LLM that Claude has
proposed for evaluating skills. In this example there are 5 levels of
prompts related to extracting gene models from GFF or GTF:

| Prompt                | Framing                                                                          | Expected failure mode                                  |
|-----------------------|----------------------------------------------------------------------------------|--------------------------------------------------------|
| **P1** Minimal        | “Load a GFF file in R and show me the genes and exons.”                          | Uses `rtracklayer` instead of `txdbmaker`; no TxDb     |
| **P2** Package hint   | “Use txdbmaker to load a GFF3 file…”                                             | Correct package, may miss `format=` or `system.file()` |
| **P3** Skill-aligned  | Names the function, the bundled file path, and asks for all three grouping calls | Near-reference; should pass most checks                |
| **P4** Full skill doc | Skill how-to injected as system prompt                                           | Highest fidelity; should match reference exactly       |
| **P5** Adversarial    | Asks for `GenomicFeatures::makeTxDbFromGFF` explicitly                           | Tests whether skill overrides legacy framing           |

</div>

<div class="section level3">

### Illustration of evaluation process

This report is explained in the vignette `small_eval_run`.

    === Static checks ===
                      check status detail
             uses txdbmaker   PASS
     avoids deprecated path   PASS
                format= arg   PASS
                    exonsBy   PASS
              transcriptsBy   PASS
                      cdsBy   PASS

    === Correctness checks ===
                   check status                               detail
                 is TxDb   PASS
              gene count   PASS                   488 (expected 488)
        transcript count   PASS                   488 (expected 488)
              exon count   PASS                 1268 (expected 1268)
              CDS groups   PASS                   488 (expected 488)
               seqlevels   PASS 'SL2.40ch00' (expected 'SL2.40ch00')
             gene1 start   PASS                                16437
               gene1 end   PASS                                18189
            gene1 strand   PASS                                    +
        gene1 exon count   PASS                                    2
       gene1 exon1 start   PASS                                16437
         gene1 exon1 end   PASS                                17275
       gene1 exon2 start   PASS                                17336
         gene1 exon2 end   PASS                                18189
          gene1 tx count   PASS                                    1
           gene1 tx name   PASS                   Solyc00g005000.2.1
      gene3ex exon count   PASS                       3 (expected 3)
     gene3ex exon starts   PASS                    68062,68344,68654
      gene4ex exon count   PASS                       4 (expected 4)
      gene5ex exon count   PASS                       5 (expected 5)
          gene5ex strand   PASS                                    -

    Overall: PASS  (27/27 checks passed)

</div>

</div>

</div>

</div>
