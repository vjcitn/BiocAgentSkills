---
name: create-skill
description: Help create a new AI agent skill through collaborative Q&A
version: 1.3.0
category: meta
tags: [meta, infrastructure, skill-creation]
author: waldronlab
---

# create-skill

Help create new AI agent skills through collaborative Q&A. Guides from rough ideas to structured skill files, focusing on intent over perfect formatting. Generates working drafts that can be refined iteratively.

## Usage

Invoke this skill when you want to create a new skill. Describe what you need:
- "Help me create a new skill for [domain/purpose]"
- "I want to make a skill that does [rough description]"
- "Create a skill for [workflow description]"

The skill guides you through the creation process interactively.

## Prerequisites

- You have a general idea of what you want the skill to do
- Working directory is the ai-agent-skills repository (or you can specify where to save)
- Existing domain directories (skills/*, or you're creating a new domain)

## Process

The skill creation process follows these steps:
1. Understand the user's intent through Q&A
2. Determine domain and location
3. Outline the process steps
4. Generate the skill file
5. Review and refine with user feedback
6. **Validate** the skill against repository standards
7. Update repository documentation (only after validation passes)

### 1. Understand the Intent

Start with open-ended questions to understand what you want:

**Core Questions**:
- "What problem are you trying to solve?"
- "Who would use this skill?" (developers, data analysts, etc.)
- "Can you give me an example of when you'd use this?"
- "What would be the typical input/output?"

**Listen for**:
- Domain context (R packages, metagenomics, repository maintenance)
- User type (package developers, data analysts, contributors)
- Workflow integration (when in their process would they invoke this?)
- Dependencies on other tools or files

**Accept rough descriptions**:
- "I want something that helps with X"
- "Like skill Y but for Z instead"
- "Automate this annoying manual process"
- "I want to create a skill for X data analysis"

### 2. Determine Domain and Location

**Existing domains**:
- `meta` - Repository infrastructure and skill system itself
- `r-packages` - R/Bioconductor package development and analysis
- `metagenomics` - Metagenomics workflows and data processing
- `statistical-methods` - Statistical analysis and methods

**If uncertain**:
- Suggest the most relevant domain
- If truly novel, discuss creating a new domain
- Explain that domain grouping helps discoverability and organization

**Determine filename**:
- Convert purpose to kebab-case: "analyze R package" → `analyze-r-package`
- Keep it descriptive but concise
- Check if similar skills exist to avoid duplication

### 3. Outline the Process

**Ask**: "Walk me through the steps - what should happen when someone uses this skill?"

**Capture**:
- Major steps in order
- Key decisions or branching points
- Required inputs at each stage
- Expected outputs
- Strategic code snippets (as guardrails for specific APIs, lab standards, or overcoming LLM anti-patterns)

**Accept**:
- High-level descriptions: "first it reads some files, then analyzes them"
- References to existing patterns: "like how analyze-r-package does it"
- Uncertain details: "probably need to check X, not sure exactly how"
- Platform-agnostic language: "read the config" not "use the Read tool"

**Help clarify**:
- Break down complex steps
- Identify implicit dependencies
- Suggest standard approaches for common tasks

### 4. Generate the Skill File

Create a well-structured skill file following the standard format:

**YAML Frontmatter** (see AGENTS.md § Skill File Format for complete specification):
- Required fields: `name` (kebab-case), `description` (one-line), `version` (1.0.0), `category`
- Optional fields: `tags`, `author`
- Prohibited fields: `platforms`, `triggers` (agent-agnostic design)

**Main Content Sections** (see AGENTS.md § Content Structure):
1. **Title and Overview** - What the skill does, why it's useful, who should use it
2. **Usage** - Natural language invocation examples
3. **Prerequisites** - Required files, setup, dependencies (if any)
4. **Process** - Numbered steps with platform-agnostic descriptions
5. **Output Format** - What the skill produces (if applicable)
6. **Examples** - Concrete usage scenarios (can add later)
7. **Notes** - Additional context, caveats, future enhancements (optional)

**Template Approach**:
- Fill in what's clear from the conversation
- Use TODO markers for uncertain sections
- Prioritize clarity over completeness
- Skills can be iterated on

### 5. Review and Refine

After generating the draft:

**Present summary**:
- "I've created `skills/[name]/SKILL.md`"
- "Here's what it does: [brief summary]"
- "Key sections: [list]"

**Invite feedback**:
- "What would you like to adjust?"
- "Are there sections that need more detail?"
- "Did I capture your intent correctly?"

**Offer next steps**:
- "You can refine this iteratively as you test it"
- "Want to add examples or error handling?"
- "Ready to validate and document this skill?"

### 6. Validate the Skill

Before updating repository documentation, validate that the skill meets waldronlab standards:

**Run validation**:
- Invoke `validate-skill` on the newly created skill file
- Review the validation report

**Address issues**:
- Fix any CRITICAL issues (required for standards compliance)
- Strongly consider fixing WARNING issues
- Note INFO suggestions for future improvements

**If validation fails**:
- Help user fix the issues
- Re-run validation after fixes
- Iterate until validation passes

**If validation passes**:
- Confirm: "✅ Validation passed! Ready to update repository documentation?"
- Only proceed to documentation step if validation is successful

### 7. Update Repository Documentation

After the skill file is validated, use `document-skill` to automatically update SKILLS.md:

**Invoke document-skill**:
- Natural language: "Document the [skill-name] skill"
- The document-skill will:
  - Read and parse the skill file
  - Generate the SKILLS.md entry with all required sections
  - Update category and tag tables
  - Suggest relevant use case workflows
  - Show previews and ask for confirmation before applying

**Note on platform instructions**:
- `instructions/*.md` reference SKILLS.md as the single source of truth
- No updates needed to these files when adding new skills
- They will automatically discover the skill via SKILLS.md
- Platform-specific setup is documented in instructions/{agent}.md

**Completion**:
After document-skill completes, confirm with user:
```
✅ Skill creation and documentation complete!

Next steps:
- Commit the new skill file and updated SKILLS.md
- Test the skill on your platform
- Optional: Submit a PR for review
```

## Output Format

Generate a markdown file with YAML frontmatter and markdown sections:

```markdown
---
name: skill-name
description: Brief purpose
version: 1.0.0
category: domain
tags: [tag1, tag2]
author: waldronlab
---

# skill-name

Overview paragraph(s).

## Usage
...

## Prerequisites
...

## Process

### 1. First Step
...

### 2. Second Step
...

## Output Format
...

## Examples
...

## Notes
...
```

**Save to**: `skills/[skill-name]/SKILL.md`

## Key Principles

- **Skills are agent-agnostic**: No platform-specific metadata in the file
- **Natural language is canonical**: Agents match user intent to the description field
- **Platform shortcuts are optional**: Platform adapters may provide conveniences (slash commands, @workspace patterns) but aren't required
- **Describe what, not how**: Use "read the file" not "use Read tool"
- **Iterate, don't perfect**: First draft can be incomplete
- **Avoid duplication**: Reference authoritative sources instead of copying content

## Platform-Specific Notes

Skills contain no platform-specific code. Platform adapters (instructions/{agent}.md) document setup and invocation patterns for each platform, keeping skill files universal.

## Guidance for AI Agents

### Being a Good Collaborator

**DO**:
- Ask clarifying questions
- Suggest similar existing skills as reference
- Help break down complex workflows into steps
- Offer options when uncertain
- Accept incomplete or rough ideas
- Use conversational language
- Iterate based on feedback

**DON'T**:
- Demand perfect specifications upfront
- Reject ideas for being too vague
- Enforce strict formatting during brainstorming
- Overwhelm with too many questions at once
- Create the file without understanding intent

### Avoiding SSOT Violations and Duplication

**Critical principle**: Never duplicate content that exists in authoritative sources.

**What NOT to duplicate**:
- ❌ YAML field specifications (defined in AGENTS.md § Skill File Format)
- ❌ Required/prohibited field lists (defined in AGENTS.md § Minimal Required Fields and § What NOT to Include)
- ❌ Platform-agnostic principles (defined in AGENTS.md § Agent Neutrality)
- ❌ Content structure requirements (defined in AGENTS.md § Content Structure)
- ❌ Validation criteria (defined in AGENTS.md and enforced by validate-skill)
- ❌ Issue type labels or severity definitions from external sources (use references)

**When to reference vs duplicate**:
- **Reference**: Format specifications, field definitions, standards, external checklists
- **Include**: Skill-specific logic, domain knowledge, concrete examples, workflow steps

**How to reference properly**:
```markdown
✅ Good: "Check that frontmatter conforms to AGENTS.md § Skill File Format"
✅ Good: "Use the standardized issue labels defined in the audit instructions gist"
✅ Good: "See AGENTS.md § Minimal Required Fields for complete list"

❌ Bad: List all required fields (name, description, version, category...)
❌ Bad: Copy the YAML template from AGENTS.md
❌ Bad: Duplicate issue type labels from external source
```

**Signs of SSOT violation**:
- Listing specific YAML fields with descriptions
- Showing YAML frontmatter templates
- Repeating validation rules
- Copying external checklists or classification systems
- Explaining format requirements already in AGENTS.md

**Fix pattern**: Replace with "See [SOURCE] § [SECTION] for [WHAT]"

### Handling Uncertainty

**If unclear about**:
- **Domain**: Suggest the closest match, explain it can be moved later
- **Steps**: Help walk through a concrete example
- **Output format**: Suggest "produces markdown summary" or similar
- **Completeness**: Use placeholders (`<!-- TODO: ... -->`) and iterate

### Starting from Examples

If user says "like skill X but for Y":

1. Read the referenced skill
2. Identify the core pattern
3. Ask what should be different
4. Adapt structure and logic
5. Generate the variant

## Integration with Other Skills

**Complements**:
- **validate-skill** - Validates the new skill before documentation (automatic in step 6)
- **document-skill** - Automates SKILLS.md updates (automatic in step 7)
- **check-waldronlab-skills** - For discovering existing skills before creating duplicates
- **SKILL_STANDARD.md** - Reference for format details
- **AGENTS.md** - Understanding agent behavior and discovery

**Workflow Integration**:
1. Use `create-skill` to generate the skill file
2. Use `validate-skill` to ensure standards compliance (automatic in step 6)
3. Use `document-skill` to update SKILLS.md (automatic in step 7)
4. Use `check-waldronlab-skills` to verify the skill is discoverable

**Not a replacement for**:
- Manual refinement and testing
- Domain expertise in skill logic
- Reading SKILLS.md to understand what already exists

## Examples

### Example 1: Creating from Scratch

**User**: "I want to make a skill that helps validate R package documentation"

**Agent**: Engages in Q&A to understand:
- What documentation aspects to validate (roxygen, vignettes, examples)
- When to use it (before committing, code review)
- Whether to check or suggest fixes

Result: `skills/validate-r-documentation/SKILL.md`

### Example 2: Starting from Rough Idea

**User**: "Something that automates the boring parts of creating Bioconductor packages"

**Agent**: Clarifies:
- Which specific parts (directory structure, DESCRIPTION, boilerplate)
- Full new package vs specific tasks
- Interactive or config-driven

Result: `skills/scaffold-bioconductor-package/SKILL.md` (simplified version)

### Example 3: Converting Existing Workflow

**User**: "I always do these 5 steps manually: [list]. Can we make a skill?"

**Agent**: Helps structure the workflow and generate:

Result: `skills/[domain]/[workflow-name]/SKILL.md` capturing your process

## Notes

- First draft doesn't need to be perfect—iteration expected
- Test the skill and refine based on feedback
- Use relevant metadata tags to improve discovery
- Run `validate-skill` before `document-skill` to check standards compliance
- Goal: lower the barrier to creating skills and sharing workflows

---

**Related**: See [SKILL_STANDARD.md](../../SKILL_STANDARD.md) for technical format details. See [AGENTS.md](../../AGENTS.md) for how agent discovery and invocation work.
