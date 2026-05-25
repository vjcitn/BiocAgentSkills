# Available Skills

This is the canonical index of all available AI agent skills in the waldronlab/ai-agent-skills repository. Use this to discover and understand what skills are available and when to use them.

## Quick Start

1. **Browse by category** below to find a skill that matches your need
2. **Read the skill description** to understand when to use it
3. **Invoke naturally**: Describe what you need to your AI agent
   - Example: "Help me create a new skill"
   - Agent will match this to the appropriate skill and invoke it

**Platform shortcuts**: Optional shortcuts (like `/skill-name` or `@workspace` patterns) are documented in [instructions/](instructions/) for each platform.

## Setup & Discovery

**First time?**
- See [instructions/claude.md](instructions/claude.md) (Claude Code)
- See [instructions/copilot.md](instructions/copilot.md) (GitHub Copilot)

**Understanding the design:**
- See [AGENTS.md](AGENTS.md) for how skill discovery and invocation work

## Meta Skills

Infrastructure and workflow skills for working with this repository itself.

### create-skill

**Purpose**: Help create a new AI agent skill through collaborative Q&A

**Location**: `skills/create-skill/SKILL.md`

**When to use**:
- Creating a new skill from scratch
- Converting a manual workflow into a reusable skill
- Starting from a rough idea

**Invocation**:
- "Help me create a new skill"
- "Create a skill for [domain]"
- "I want to make a skill that..."

**What happens**:
- Collaborative Q&A to understand your intent
- Guidance on domain and location
- Step-by-step process outline
- Generated skill file in markdown format
- Automatic validation with `validate-skill`
- Automatic documentation update with `document-skill`

**Output**: A complete skill with validated file and updated SKILLS.md, ready for testing and committing

**Related skills**: validate-skill, document-skill, check-waldronlab-skills

---

### check-waldronlab-skills

**Purpose**: List and verify installed waldronlab skills

**Location**: `skills/check-waldronlab-skills/SKILL.md`

**When to use**:
- Verifying skills are correctly installed
- Discovering what skills are available
- Troubleshooting skill discovery issues
- Checking setup for Claude Code or Copilot

**Invocation**:
- "What skills are available?"
- "List waldronlab skills"
- "Load waldronlab skills"
- "Do I have the waldronlab skills?"

**What happens**:
- Scans the repository for available skills
- Verifies your agent can access them
- Lists skills by category with descriptions
- Suggests next steps

**Output**: List of available skills and setup status

---

### validate-skill

**Purpose**: Validate that a skill conforms to the ai-agent-skills repository standards

**Location**: `skills/validate-skill/SKILL.md`

**When to use**:
- Creating new skills (before committing)
- Reviewing PRs
- Ensuring existing skills meet current standards
- CI/CD validation in automated workflows

**Invocation**:
- "Validate this skill"
- "Check if skills/[skill-name]/SKILL.md meets standards"
- "Does this skill conform to standards?"

**What happens**:
- Runs generic validation (markdownlint, yamllint) if available
- Validates waldronlab-specific requirements:
  - Checks for prohibited fields (platforms, triggers)
  - Ensures platform-agnostic language (no tool references)
  - Validates required fields (name, description, version, category)
  - Checks naming conventions and consistency
- Generates detailed report with issues, fixes, and references to AGENTS.md/SKILL_STANDARD.md

**Output**: Comprehensive validation report with pass/fail status, categorized issues (CRITICAL/WARNING/INFO), and specific fix suggestions

**Related skills**: create-skill, check-waldronlab-skills, document-skill

---

### document-skill

**Purpose**: Automate documentation updates to SKILLS.md after creating or modifying a skill

**Location**: `skills/document-skill/SKILL.md`

**When to use**:
- After creating a new skill with create-skill
- After modifying an existing skill
- When you need to update SKILLS.md with new skill information
- As part of the skill creation workflow

**Invocation**:
- "Document the new skill I just created"
- "Update SKILLS.md for the validate-r-docs skill"
- "Add documentation for my new skill"

**What happens**:
- Reads and validates the skill file
- Extracts metadata and structure from YAML frontmatter
- Auto-generates invocation examples and asks for confirmation
- Creates complete SKILLS.md entry with all sections
- Updates category, tag tables, and use case workflows
- Shows preview diffs and asks for confirmation before applying changes

**Output**: Updated SKILLS.md with the skill entry added to all relevant sections

**Related skills**: create-skill, validate-skill, check-waldronlab-skills

---

## R/Bioconductor Package Skills

Skills for analyzing, documenting, and developing R/Bioconductor packages following waldronlab conventions.

### analyze-r-package

**Purpose**: Analyze R/Bioconductor package structure and characteristics

**Location**: `skills/analyze-r-package/SKILL.md`

**When to use**:
- Understanding a package's architecture and design
- Determining package type (data, analysis, infrastructure)
- Identifying key functions and data structures
- Before generating documentation for a package

**Invocation**:
- "Analyze this R package"
- "What type of package is this?"
- "Tell me about the package structure"

**What happens**:
- Reads package metadata (DESCRIPTION, README, code)
- Identifies package type and purpose
- Lists key functions and classes
- Detects data access patterns (ExperimentHub, DuckDB, etc.)
- Summarizes architecture and design patterns

**Output**: Structured analysis of the package

---

### create-package-instructions

**Purpose**: Generate comprehensive .github/instructions files for R/Bioconductor packages

**Location**: `skills/create-package-instructions/SKILL.md`

**When to use**:
- Creating AI agent instructions for a new R package
- Generating documentation for AI agents working on the package
- Standardizing package documentation across waldronlab
- After analyzing a package with analyze-r-package

**Invocation**:
- "Create .github/instructions for this package"
- "Generate AI agent instructions"
- "Create instructions for this R package"

**What happens**:
- Uses analyze-r-package internally to understand the package
- Reads shared standards (Bioconductor conventions, waldronlab patterns)
- Generates modular instruction files in .github/instructions/
- Creates package-specific guidance
- References reusable standards to avoid duplication

**Output**:
- `.github/instructions/00-overview.md` - Package classification and architecture
- `.github/instructions/10-data-access.md` - Data handling patterns (if applicable)
- `.github/instructions/20-development.md` - Development patterns and conventions
- `.github/instructions/30-vignettes.md` - Vignette purposes and standards (if applicable)

**Related skills**: analyze-r-package, update-package-instructions

---

### update-package-instructions

**Purpose**: Update existing .github/instructions files based on recent package changes

**Location**: `skills/update-package-instructions/SKILL.md`

**When to use**:
- Refreshing package instructions after major changes
- Updating instructions when architecture changes
- Adding new data patterns or functions
- Keeping AI agent instructions current with the package

**Invocation**:
- "Update the package instructions"
- "Refresh .github/instructions"
- "Update instructions based on recent changes"

**What happens**:
- Re-analyzes the current package state
- Compares with existing instructions
- Updates changed sections
- Preserves customizations and hand-written notes
- References updated standards if needed

**Output**: Updated `.github/instructions/` files

**Related skills**: analyze-r-package, create-package-instructions

---

### improve-code-coverage

**Purpose**: Analyze R package code coverage using covr, classify testing gaps, and proactively write test cases to improve coverage and result correctness.

**Location**: `skills/improve-code-coverage/SKILL.md`

**When to use**:
- Increasing an R package's test coverage
- Evaluating testing rigor and identifying gaps
- Proactively writing test cases categorized by normal use, edge cases, error handling, and correctness

**Invocation**:
- "Check my code coverage and help me write missing tests."
- "Run covr on the package and improve testing for uncovered lines in R/my_function.R."
- "Improve code coverage, focusing on edge cases and correctness."
- "Summarize current code coverage."

**What happens**:
- Runs `covr` package coverage analysis and extracts percentages for `R/` and `src/`.
- Summarizes coverage results, evaluating the types of tests present.
- Identifies uncovered functions and logic branches.
- Classifies missing testing needs into Normal Use, Edge Cases, Error Handling, or Correctness.
- Drafts new `testthat` code blocks targeting identified gaps.

**Output**: A chat summary breaking down coverage by test category, and code blocks containing `testthat` cases.

**Related skills**: analyze-r-package, security-audit-r-package

---

### security-audit-r-package

**Purpose**: Perform comprehensive security audit of R/Bioconductor packages

**Location**: `skills/security-audit-r-package/SKILL.md`

**When to use**:
- Auditing packages before CRAN/Bioconductor submission
- Self-review for security vulnerabilities and code quality issues
- Reviewing native code (C/C++/Fortran) for memory safety issues
- Before public release or major version updates

**Invocation**:
- "Run security audit on this R package"
- "Check this package for security vulnerabilities"
- "Perform security review of this Bioconductor package"
- "Security audit only the R/ directory"

**What happens**:
- Determines audit scope (default: DESCRIPTION, NAMESPACE, R/, src/)
- Fetches standardized security audit instructions from reference gist
- Reads all package files in the audit scope
- Analyzes for security vulnerabilities, native code issues, code quality concerns, and dependency risks
- Generates security report with standardized issue labels and severity ratings
- Outputs report to console with flexible formatting based on context

**Output**: Security audit report (markdown format) with findings categorized by severity, or clean report if no issues found. Each issue includes standardized label, severity, location, description, and recommended fix.

**Related skills**: analyze-r-package, validate-skill, create-package-instructions

---

### update-r-news

**Purpose**: Draft or update an R package NEWS file from git commit history, examining diffs when commit messages are vague

**Location**: `skills/update-r-news/SKILL.md`

**When to use**:
- Adding a NEWS entry before a Bioconductor release
- Drafting a changelog from recent commits
- Updating `NEWS.md`, `NEWS`, or `NEWS.Rd` after a development cycle
- Saving time when commit messages alone are insufficient to write clear NEWS entries

**What happens**:
- Detects the NEWS file format in use (`NEWS.md`, `NEWS`, or `NEWS.Rd`)
- Derives the upcoming even-numbered release version from the current devel version
- Finds the last release tag and retrieves all commits since then
- Extracts PR titles from merge commits when available
- Identifies vague commit messages (≤ 3 words or known filler phrases) and inspects their diffs to infer what changed
- Categorises changes using headings already present in the NEWS file
- Shows a full preview and asks for confirmation before writing to disk

**Output**: A drafted NEWS block shown for review; upon confirmation, the updated NEWS file on disk with the new version block prepended.

**Related skills**: analyze-r-package, update-package-instructions

---

## Metagenomics Skills

*Planned for future release*

Skills for standard metagenomics data processing and analysis workflows.

**Coming soon**:
- Standard preprocessing pipelines
- Taxonomic profiling workflows
- Functional analysis patterns

---

## Statistical Methods Skills

*Planned for future release*

Skills for statistical analysis patterns in microbiome and multi-omics research.

**Coming soon**:
- Differential abundance analysis
- Dimension reduction approaches
- Batch effect correction
- Multi-omics integration

---

## Skill Categories & Tags

### By Category

| Category | Skills | Purpose |
|----------|--------|---------|
| **meta** | create-skill, check-waldronlab-skills, document-skill, validate-skill | Repository and workflow infrastructure |
| **r-packages** | analyze-r-package, create-package-instructions, improve-code-coverage, security-audit-r-package, update-package-instructions, update-r-news | R/Bioconductor package development |
| **metagenomics** | (Planned) | Metagenomics data workflows |
| **statistical-methods** | (Planned) | Statistical analysis patterns |

### By Tag

| Tag | Skills | Use Case |
|-----|--------|----------|
| **infrastructure** | create-skill, check-waldronlab-skills, document-skill, validate-skill | Repository and workflow tasks |
| **testing** | improve-code-coverage | Software testing and coverage |
| **validation** | security-audit-r-package, validate-skill | Quality control and standards compliance |
| **quality-control** | security-audit-r-package, validate-skill | Ensuring skill quality |
| **documentation** | create-package-instructions, document-skill, update-package-instructions, update-r-news | Generating and maintaining docs |
| **automation** | document-skill, update-r-news | Automating repetitive documentation tasks |
| **analysis** | analyze-r-package | Understanding code and architecture |
| **security** | security-audit-r-package | Security audits and vulnerability detection |
| **audit** | security-audit-r-package | Comprehensive code auditing |
| **bioconductor** | analyze-r-package, create-package-instructions, improve-code-coverage, security-audit-r-package, update-package-instructions, update-r-news | Bioconductor-specific workflows |
| **code-coverage** | improve-code-coverage | Code coverage analysis |
| **covr** | improve-code-coverage | Tools wrapping the covr package |
| **data-access** | analyze-r-package (detects), create-package-instructions | Working with remote data |
| **git** | update-r-news | Git-based workflows |
| **changelog** | update-r-news | Changelog and release note generation |
| **news** | update-r-news | R package NEWS file management |

---

## Finding Skills by Use Case

### "I want to work on an R package..."

1. **Understand the package** → `analyze-r-package`
2. **Create AI instructions** → `create-package-instructions`
3. **Improve test coverage** → `improve-code-coverage`
4. **Audit for security issues** → `security-audit-r-package`
5. **Keep instructions updated** → `update-package-instructions`
6. **Update NEWS for upcoming release** → `update-r-news`

### "I want to create a new skill..."

1. **Get guided help** → `create-skill`
2. **Validate it meets standards** → `validate-skill`
3. **Update documentation** → `document-skill`
4. **Verify it's accessible** → `check-waldronlab-skills`

### "I want to verify my setup..."

1. **Check installed skills** → `check-waldronlab-skills`
2. See [instructions/](instructions/) for platform-specific setup

### "I want to analyze a workflow and automate it..."

1. **Create a skill for it** → `create-skill`

### "I want to ensure my skill meets standards..."

1. **Validate the skill** → `validate-skill`
2. **Fix any issues** based on the validation report
3. **Re-validate** until it passes

---

## How Skills Are Discovered and Invoked

### For Users

1. **Browse this file** (SKILLS.md) to understand what's available
2. **Describe your need** to your AI agent in natural language
3. **Agent handles the rest**:
   - Matches your description to a skill
   - Reads the skill file
   - Executes the skill process
   - Provides output

### For AI Agents

1. **Read SKILLS.md** (this file) as the primary discovery mechanism
2. **Match user intent** to skill descriptions and purposes
3. **Locate the skill file** at the specified location
4. **Read and follow** the skill documentation
5. **Execute** using your platform's available tools
6. **Deliver output** as documented in the skill

See [AGENTS.md](AGENTS.md) for the complete agent behavior standard.

---

## Contributing New Skills

Want to add a new skill?

1. **Brainstorm**: Use `create-skill` to develop your idea
2. **Create**: Follow the guidance and create the skill file
3. **Validate**: Run `validate-skill` to ensure standards compliance
4. **Document**: Use `document-skill` to update this file (SKILLS.md)
5. **Test**: Verify it works on your platform
6. **Submit**: Create a PR for review

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## Platform-Specific Information

### Claude Code

See [instructions/claude.md](instructions/claude.md) for:
- Setup and installation
- Optional `/skill-name` shortcuts
- Troubleshooting

### GitHub Copilot

See [instructions/copilot.md](instructions/copilot.md) for:
- Setup and installation
- Optional `@workspace` shortcuts
- Troubleshooting

### Other Agents

We're working on support for additional agents. See [instructions/](instructions/) for available adapters.

---

## Skill File Structure

Each skill is a markdown file with:
- **YAML frontmatter**: Metadata (name, description, version, category, tags)
- **Usage section**: How to invoke the skill
- **Prerequisites section**: What's needed before running
- **Process section**: Step-by-step instructions
- **Output section**: What the skill produces
- **Examples section**: Concrete usage scenarios
- **Optional sections**: Platform notes, error handling, etc.

For technical details on skill format, see [SKILL_STANDARD.md](SKILL_STANDARD.md).

---

## Questions?

- **How does skill invocation work?** → See [AGENTS.md](AGENTS.md)
- **How do I create a new skill?** → Use `create-skill` or see [CONTRIBUTING.md](CONTRIBUTING.md)
- **Where are the actual skill files?** → `skills/{skill-name}/SKILL.md`
- **Can I use skills on multiple platforms?** → Yes! Skills are platform-agnostic
- **How do I verify my setup?** → Use `check-waldronlab-skills` or see instructions/{agent}.md
- **I found an issue with a skill** → File an issue at https://github.com/waldronlab/ai-agent-skills/issues
- **I want to suggest a new skill** → Open a discussion at https://github.com/waldronlab/ai-agent-skills/discussions

---

**Last Updated**: 2026-04-03
**Version**: 2.0.0
**Maintained by**: waldronlab
