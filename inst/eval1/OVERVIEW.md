# waldronlab AI Agent Skills — Summary

**Repo**: `waldronlab/ai-agent-skills` · **Version**: 2.0.0 · **License**: MIT

## Purpose

A curated collection of **workflow-orchestration skills** for AI agents (Claude Code, GitHub Copilot,
Gemini) working on Waldron Lab projects at CUNY SPH. Skills teach agents domain knowledge, multi-step
processes, and Bioconductor conventions — not just code snippets.

## Design Philosophy

- **Workflow-first**: Skills define *intent* and *process*, not just syntax. Code snippets appear only
  as guardrails for highly specific APIs or standardized methods.
- **Centralized registry**: `SKILLS.md` is the single discovery index; agents read it to match user
  intent to the right skill.
- **Agent-agnostic**: No vendor-specific metadata in skill files. Platform adapters live only in
  `instructions/`.

## Repository Structure

| Path | Purpose |
|------|---------|
| `SKILLS.md` | Canonical skill index (agent discovery entrypoint) |
| `AGENTS.md` | Agent behavior contract (how skills are discovered/invoked) |
| `SKILL_STANDARD.md` | Technical format spec for authoring skills |
| `skills/{name}/SKILL.md` | One file per skill |
| `instructions/` | Platform-specific setup (Claude, Copilot, Gemini) |
| `templates/` | Reusable instruction file templates |

---

## Available Skills

### Meta Skills (repository infrastructure)

| Skill | Purpose |
|-------|---------|
| **create-skill** | Guided Q&A to build a new skill; auto-validates and updates `SKILLS.md` |
| **validate-skill** | Checks a skill file against `SKILL_STANDARD.md`; reports CRITICAL/WARNING/INFO issues |
| **document-skill** | Auto-updates `SKILLS.md` after a skill is created or modified |
| **check-waldronlab-skills** | Lists installed skills and verifies agent access |

### R / Bioconductor Package Skills

| Skill | Purpose |
|-------|---------|
| **analyze-r-package** | Reads `DESCRIPTION`, `README`, and code to classify package type, identify key functions, and detect data-access patterns (ExperimentHub, DuckDB, etc.) |
| **create-package-instructions** | Generates `.github/instructions/` for a package (overview, data-access, development, vignettes files) |
| **update-package-instructions** | Re-analyzes a changed package and updates existing `.github/instructions/` while preserving hand-written notes |
| **improve-code-coverage** | Runs `covr`, classifies gaps (Normal Use / Edge Cases / Error Handling / Correctness), and writes `testthat` cases |
| **security-audit-r-package** | Audits `DESCRIPTION`, `NAMESPACE`, `R/`, and `src/` for security vulnerabilities, native-code memory issues, and dependency risks; produces a severity-labeled report |
| **update-r-news** | Drafts a versioned NEWS block from git history; inspects diffs for vague commits; shows a preview before writing to disk |

### Planned

- **Metagenomics**: preprocessing pipelines, taxonomic profiling, functional analysis
- **Statistical Methods**: differential abundance, dimension reduction, batch correction, multi-omics integration

---

## Typical Workflows

**Working on an R package:**

1. `analyze-r-package` — understand structure and type
2. `create-package-instructions` — generate `.github/instructions/`
3. `improve-code-coverage` — identify and fill testing gaps
4. `security-audit-r-package` — check for vulnerabilities before release
5. `update-r-news` — draft a NEWS entry for the upcoming release

**Creating a new skill:**

1. `create-skill` — guided Q&A to draft the skill file
2. `validate-skill` — confirm it meets standards
3. `document-skill` — update `SKILLS.md`
4. `check-waldronlab-skills` — verify the skill is accessible to your agent

---

## Installation (Claude Code)

1. Clone the repository:
   ```bash
   git clone https://github.com/waldronlab/ai-agent-skills.git

2. Add a reference in ~/.claude/CLAUDE.md:
# waldronlab AI Agent Skills

See: `/path/to/ai-agent-skills/SKILLS.md`
Behavior Standard: `/path/to/ai-agent-skills/AGENTS.md`

Describe what you need, and I'll match it to the appropriate skill.
Always follow the canonical behavior and Git workflow rules defined in AGENTS.md.
3. Restart Claude Code or reload the workspace.

For GitHub Copilot and Gemini setup, see instructions/.

---
Invocation

Skills are invoked with natural language — no rigid command syntax required. Examples:

"Analyze this R package"
"Create .github/instructions for this package"
"Check my code coverage and help me write missing tests"
"Update the NEWS file for the upcoming release"
"Help me create a new skill"

Your agent reads SKILLS.md, matches your intent to a skill, and executes the documented process.

---
Contributing

1. Use create-skill to develop your idea interactively
2. Run validate-skill to confirm standards compliance
3. Run document-skill to update SKILLS.md
4. Submit a pull request for review

See CONTRIBUTING.md for full guidelines and
SKILL_STANDARD.md for the technical format specification.

---
Maintained by: waldronlab (https://github.com/waldronlab) at CUNY SPH
Issues / Discussions: https://github.com/waldronlab/ai-agent-skills
```


