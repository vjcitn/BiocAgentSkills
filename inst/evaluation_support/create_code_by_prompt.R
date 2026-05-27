
syspr = readLines(system.file("demoskills", "genemodel.md", package="BiocAgentSkills")) |> paste(collapse="\n")

library(ellmer)
library(btw)

k = Sys.getenv("ANTHROPIC_API_KEY")
stopifnot(nchar(k)>0)

ch = chat_anthropic(system_prompt = syspr)

newprompt = readLines(system.file("evaluation_support", "prompt2.txt", package="BiocAgentSkills")) |> paste(collapse="\n")

ch$chat(btw(), newprompt)
