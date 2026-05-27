This folder is intended to manage scripts and data relevant to
evaluation of skills for agentic analysis with Bioconductor.

First draft files:

check_txdb.R - verification that a txdb object satisfies ground truth assertions
create_code_by_prompt.R - script to produce a code chunk driven by skill-informed LLM
ground_truth_bundled.R - arrangement of ground-truth facts
prompt2.txt - pure text with a prompt to skill-informed LLM
simple_eval_bundled.R - script to be run with output of create_code_by_prompt.R as follows

1) run create_code_by_prompt.R, perhaps by source()
2) extract the pure R code into a file, say "generated.R"
3) Rscript simple_eval_bundled.R generated.R > report.txt

