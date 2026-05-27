---
name: document-skill
description: Automate documentation updates to SKILLS.md after creating or modifying a skill
version: 1.0.1
category: meta
tags: [meta, infrastructure, documentation, automation]
author: waldronlab
---

# document-skill

Automate updating SKILLS.md after creating or modifying a skill. Reads the skill file, generates entries, and updates all relevant sections with user confirmation.

## Usage

Invoke this skill after creating or modifying a skill file:
- "Document the new skill I just created"
- "Update SKILLS.md for the validate-r-docs skill"
- "Add documentation for my new skill"

Platform adapters may provide optional shortcuts.

## Prerequisites

- Skill file exists at `skills/{skill-name}/SKILL.md`
- Skill file has valid YAML frontmatter with required fields
- SKILLS.md exists in the repository root
- You have write access to SKILLS.md

## Process

### 1. Input and Validation

**Identify the skill to document:**
- Accept skill name as input (e.g., "validate-r-docs")
- Construct path: `skills/{skill-name}/SKILL.md`
- Verify the file exists

**Read and parse the skill file:**
- Read the complete SKILL.md file
- Extract YAML frontmatter fields (see AGENTS.md § Minimal Required Fields)
- Parse main content sections (Overview, Usage, Process, Output Format, Examples)

**Validate completeness:**
- Confirm all required YAML fields are present
- Warn if key sections are missing (Usage, Process)
- Ask user if they want to continue despite warnings

### 2. Generate SKILLS.md Entry

**Extract information for the entry:**
- **Purpose**: Use the `description` field from YAML frontmatter
- **Location**: `skills/{skill-name}/SKILL.md`
- **When to use**: Analyze the overview and Usage section to identify use cases
- **Invocation examples**: Extract from Usage section, or generate from description
- **What happens**: Summarize the Process section steps (one bullet per major step)
- **Output**: Extract from Output Format section, or infer from Process section
- **Related skills**: Identify skills with same category or overlapping tags

**Auto-generate invocation examples:**
- Create 2-3 natural language examples based on the description
- Present to user: "I generated these invocation examples: [list]. Are these good, or would you like to modify them?"
- Allow user to edit, add, or replace examples

**Generate the full entry in SKILLS.md format:**
```markdown
### {skill-name}

**Purpose**: {description from YAML}
**Location**: `skills/{skill-name}/SKILL.md`

**When to use**:
- {use cases from analysis}

**Invocation**:
- "{natural language examples}"

**What happens**:
- {process step summaries}

**Output**: {output description}
**Related skills**: {related skills}

---
```

**Preview and confirm:**
- Display the generated entry
- Ask: "Does this entry accurately describe the skill? Would you like to make any changes?"
- Allow inline edits before proceeding

### 3. Update SKILLS.md Sections

**Read current SKILLS.md:**
- Parse the complete file
- Identify existing sections:
  - Category sections (## Meta Domain, ## R/Bioconductor Domain, etc.)
  - By Category table
  - By Tag table
  - Finding Skills by Use Case sections

**Check if skill already exists:**
- Search for existing entry with matching skill name
- If found:
  - Show diff between current and proposed entry
  - Ask: "This skill already exists in SKILLS.md. Would you like to replace it?"
  - Options: Replace, Skip, Edit manually
- If not found, proceed to add

**Add to category section:**
- Locate or create the appropriate category section (e.g., "## Meta Domain")
- Insert the full entry in alphabetical order within the category
- Preview the updated section

**Update "By Category" table:**
- Locate the row for the skill's category
- Add skill name to the comma-separated list (in alphabetical order)
- Preview the updated row

**Update "By Tag" table:**
- For each tag in the skill's YAML:
  - Locate existing row for the tag, or create new row if needed
  - Add skill name to the comma-separated list (in alphabetical order)
- Preview the updated tag rows

**Suggest use case workflows:**
- Analyze the skill's purpose and context
- Identify existing use case sections that might be relevant
- Ask: "This skill might fit into these use case workflows: [list]. Would you like to add it to any? Or should I create a new use case section?"
- Options for each use case:
  - Add (with suggested context)
  - Skip
  - Create new section (prompt for section name and description)

**Show complete preview:**
- Display all changes to SKILLS.md (diff format)
- Summarize: "Ready to update SKILLS.md with: [list of changes]"

### 4. Confirm and Apply

**Final confirmation:**
- Show summary of all updates:
  ```
  Updates to SKILLS.md:
  ✓ Added full entry to {category} section
  ✓ Updated By Category table
  ✓ Updated By Tag table for: {tag1, tag2, ...}
  ✓ Added to use case workflow: {use case name (if applicable)}
  ```
- Ask: "Apply these changes to SKILLS.md?"
- Options: Yes / Show full diff / Cancel

**Apply changes:**
- Write the updated SKILLS.md
- Confirm: "✅ Documentation updated successfully!"
- Suggest next steps: "You can now commit these changes or continue refining the skill."

**Handle errors:**
- If write fails (permissions, file locked, etc.), report the error clearly
- Offer to save changes to a temporary file for manual application

## Output Format

This skill produces:
1. **Updated SKILLS.md** with the new skill entry in all relevant sections
2. **Preview diffs** shown during the process for user review
3. **Confirmation messages** at each step indicating what was changed

No new files are created—only SKILLS.md is modified.

## Examples

### Example 1: Documenting a New Skill

**User**: "Document the validate-r-docs skill I just created"

**Skill execution**:
1. Reads `skills/validate-r-docs/SKILL.md`
2. Extracts: name="validate-r-docs", description="Validate R package documentation for completeness", category="r-packages"
3. Generates entry with invocation examples:
   - "Validate the documentation in this R package"
   - "Check if my R package docs are complete"
4. Shows preview, user confirms
5. Adds to "R/Bioconductor Domain" section
6. Updates By Category table (r-packages row)
7. Updates By Tag table (r-packages, documentation rows)
8. Suggests adding to "Creating R Packages" use case workflow
9. User confirms, SKILLS.md is updated
10. Reports: "✅ Documentation updated successfully!"

### Example 2: Updating an Existing Skill

**User**: "Update SKILLS.md for the create-skill skill"

**Skill execution**:
1. Reads `skills/create-skill/SKILL.md`
2. Finds existing entry in SKILLS.md
3. Shows diff between current and proposed entry:
   ```diff
   - **Purpose**: Help create new skills
   + **Purpose**: Help create a new AI agent skill through collaborative Q&A
   ```
4. User confirms replacement
5. Updates all relevant sections
6. Reports changes applied

### Example 3: Creating a New Use Case Section

**User**: "Document the new metagenomics-qc skill"

**Skill execution**:
1. Analyzes skill: category="metagenomics", purpose="Quality control for metagenomic data"
2. Suggests existing workflows: "Analyzing Metagenomic Data"
3. User says: "Create a new section called 'Quality Control Workflows'"
4. Prompts: "Describe this use case section: [user provides description]"
5. Creates new section in SKILLS.md:
   ```markdown
   #### Quality Control Workflows

   {user description}

   **Relevant skills**: metagenomics-qc
   ```
6. Adds to all other sections as normal
7. Reports: "✅ Created new use case section and updated documentation!"

## Notes

- Interactive by design—confirms with user at multiple points
- Idempotent—can run multiple times, shows diff before replacing
- Non-destructive—all changes shown before applying
- Run `validate-skill` first to ensure standards compliance
- Changes can be reviewed in git diff and committed normally

## Integration with Other Skills

**Workflow integration**:
1. `create-skill` → creates the skill file
2. `validate-skill` → ensures standards compliance
3. **`document-skill`** → updates SKILLS.md (this skill)
4. `check-waldronlab-skills` → verifies discoverability

**Complements**:
- **create-skill**: Automatically invoked at the end of create-skill workflow (step 7)
- **validate-skill**: Should be run before document-skill to catch issues early
- **check-waldronlab-skills**: Useful after documenting to verify the skill is discoverable

**Not a replacement for**:
- Manual editing of SKILLS.md for complex cases
- Updating other documentation (README.md, CONTRIBUTING.md, etc.)
- Platform-specific setup instructions (now handled by referencing SKILLS.md)

---

**Related**: See [SKILLS.md](../../SKILLS.md) for the skill catalog format. See [create-skill](../create-skill/SKILL.md) for the skill creation workflow. See [validate-skill](../validate-skill/SKILL.md) for validation before documenting.
