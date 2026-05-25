# BiocAgentSkills -- packaging and documenting resources for AI agent training and use with Bioconductor

## Main purpose of the R package approach

Bioconductor has a long history of producing self-describing data structures and
self-documenting software modules in R packages.  The R package framework
structures code, data, metadata, and documentation in ways that support
computational assessment and verification.  This particular package represents
an experiment in the use of R package structure and function to manage content
of agent skills documents.

We use the `inst/` folder to manage skills and evaluations.  See the BiocAgentSkills
vignette for more details.

## Key online resources

Ultimately this package will not contain skill documents, but will provide
verifiable references to relevant skills.  Principal examples include

- [Waldronlab skills](https://github.com/waldronlab/ai-agent-skills)
- Sean Davis' [Bioconductor task skills](https://github.com/Bioconductor/ai-agent-skills/blob/devel/skills/bioc-howto/SKILL.md)

In the initial development of this package, Claude was asked to create
an evaluation framework for one of the Bioconductor task skills.  Thus there
are "frozen" versions of the skills used for this process under `/inst/eval1`.

A general introduction to agentic coding is [available](https://github.com/seandavi/agentic-coding-intro).

## Design Philosophy of these Skills

### Workflow Orchestration vs. Code-Centric Snippets

Many AI skill repositories are code snippet libraries, providing the AI with advanced copy-paste templates to execute a single task. While fast, this **Code-Centric approach** is brittle, lacks autonomy, and misses the "why" behind the code.

These skills instead provide **Workflow/Process Orchestration**. They treat the AI like a junior developer given a Standard Operating Procedure (SOP). Rather than just providing raw syntax, a skill defines the *intent*, the *multi-step workflow*, and the *domain knowledge* required.

For example, our code coverage skill doesn't just provide the command to run `covr`; it orchestrates a workflow: run the coverage, summarize the gaps, classify testing needs (Normal Use, Edge Cases, Error Handling, Correctness), and proactively write new test cases based on those criteria. This approach enables high autonomy, encourages the AI to follow the intent of the process orchestration, and allows it to adapt to different project structures using its general reasoning capabilities.
