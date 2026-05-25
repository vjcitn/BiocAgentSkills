---
name: validate-skill
description: Validate that a skill conforms to the ai-agent-skills repository standards
version: 1.1.0
category: meta
tags: [meta, infrastructure, validation, quality-control]
author: waldronlab
---

# validate-skill

Validate that a skill conforms to waldronlab standards. Uses generic validators (markdownlint, yamllint) for basic checks, then adds waldronlab-specific validation for platform-agnostic compliance and repository conventions.

## Usage

Invoke this skill to validate a skill file:
- "Validate this skill"
- "Check if skills/[skill-name]/SKILL.md meets standards"
- "Does this skill conform to the repository standards?"
- "Run validation on [skill-name]"

## Prerequisites

- Working directory is the ai-agent-skills repository (or path to skill file is provided)
- Access to SKILL_STANDARD.md and AGENTS.md for reference standards
- Target skill file exists at `skills/{skill-name}/SKILL.md`
- Optional: `markdownlint` and `yamllint` installed for enhanced generic validation

## Process

### 1. Locate the Target Skill File

Determine which skill to validate:
- If user specifies a skill name, look for `skills/{skill-name}/SKILL.md`
- If in a skill directory, validate the current `SKILL.md`
- If user provides a file path, use that path
- If ambiguous, ask which skill to validate

### 2. Run Generic Validation (Optional but Recommended)

Use existing generic validators if available:

**Markdown Validation** (using markdownlint or similar):
```bash
markdownlint skills/{skill-name}/SKILL.md
```
This checks:
- Markdown syntax correctness
- Heading level consistency
- List formatting
- Line length (if configured)
- Trailing whitespace

**YAML Validation** (using yamllint or similar):
```bash
yamllint -d relaxed skills/{skill-name}/SKILL.md
```
This checks:
- YAML frontmatter syntax validity
- Proper YAML structure
- Quote consistency

If these tools are not available, skip to waldronlab-specific validation (step 3). Generic validation is recommended but not required.

### 3. Read the Skill File

Read the complete skill file to analyze waldronlab-specific requirements.

### 4. Validate Waldronlab-Specific YAML Requirements

Check that frontmatter conforms to AGENTS.md § Skill File Format:

**Required Fields** (AGENTS.md § Minimal Required Fields):
- All required fields present: `name`, `description`, `version`, `category`
- `name` is kebab-case and matches directory name
- `description` is one clear sentence (ideally under 150 characters)
- `version` follows semantic versioning (MAJOR.MINOR.PATCH)
- `category` is a valid domain

**Prohibited Fields** (AGENTS.md § What NOT to Include):
- No `platforms` or `triggers` fields (violates agent-agnostic principle)

### 5. Validate Waldronlab File Structure

Check waldronlab-specific section requirements:

**Required Sections**:
- Title (# skill-name) matching frontmatter `name`
- Overview paragraph(s) after title
- ## Usage (with natural language invocation examples)
- ## Process (with numbered subsections: ### 1., ### 2., etc.)

**Strongly Recommended Sections**:
- ## Prerequisites (if applicable)
- ## Output Format (if applicable)
- ## Examples

### 6. Validate Platform-Agnostic Compliance

Check compliance with AGENTS.md § Agent Neutrality:

**Prohibited** (AGENTS.md § What NOT to Include):
- Tool references ("use Read tool", "use Write tool", "use Edit tool", etc.)
- Platform commands in Usage (`/skill-name`, `@workspace skill-name`)
- Platform-specific instructions in Process section

**Required**:
- Generic actions ("read the file", "write to", "search for", "edit the section")
- Natural language in Usage section
- Platform shortcuts only in Platform-Specific Notes (if needed)

### 7. Check Workflow vs. Code-Centric Design

Verify the skill adheres to the Workflow Orchestration philosophy (README.md § Workflow Orchestration vs. Code-Centric Snippets):

**Code Snippet Usage**:
- Ensure the skill is not just a raw code snippet or code template.
- Any provided code snippets must be embedded as "guardrails" within a broader, numbered workflow.
- Snippets should serve a specific purpose (e.g., highly specific APIs, standardized lab methodology, or overcoming LLM anti-patterns).

### 8. Check Waldronlab Naming Conventions

Validate waldronlab-specific naming and consistency:

**Directory and File Naming**:
- Skill directory name matches frontmatter `name` field
- File is named `SKILL.md` (uppercase)
- Directory name is kebab-case

**Content Consistency**:
- Title (# heading) matches `name` field
- Skill referenced consistently throughout the file
- References to SKILL_STANDARD.md, AGENTS.md, SKILLS.md use correct relative paths

### 9. Check for SSOT Violations

Detect content duplication that violates single source of truth principle:

**Common SSOT violations to flag**:
- YAML field specifications (should reference AGENTS.md § Skill File Format)
- Required/prohibited field lists (should reference AGENTS.md § Minimal Required Fields / § What NOT to Include)
- Validation criteria or format rules (should reference AGENTS.md or SKILL_STANDARD.md)
- External checklist duplication (should reference external source as authority)
- Platform-agnostic principles (should reference AGENTS.md § Agent Neutrality)

**Valid references pattern**: "See AGENTS.md § [Section]" or "defined in [source]"

**Red flags**:
- Lists of YAML fields with descriptions
- YAML frontmatter templates
- Repeated validation rules from AGENTS.md
- Copied content from external sources (gists, standards documents)

### 10. Generate Validation Report

Create a comprehensive report with:

**Status Line**:
- `✅ PASS: All validation checks passed`
- `❌ FAIL: [N] issues found`

**Generic Validation Results** (if run):
- Report markdownlint/yamllint results
- Note: These are standard markdown/YAML issues, not waldronlab-specific

**Waldronlab-Specific Issues** (for each issue found):
- **Severity**: CRITICAL, WARNING, or INFO
- **Location**: Section name or line number (if determinable)
- **Issue**: Clear description of what violates waldronlab standards
- **Fix**: Specific suggestion for how to fix it
- **Reference**: Link to AGENTS.md or SKILL_STANDARD.md section if applicable

**Example Waldronlab Issue Format**:
```
❌ CRITICAL: Prohibited field in YAML frontmatter (line 5)
   Issue: Found 'platforms:' field which violates agent-agnostic standard
   Fix: Remove the 'platforms:' field entirely
   Reference: See AGENTS.md section "What NOT to Include"
```

**Summary Statistics**:
- Generic validation: Pass/Fail (if run)
- Waldronlab-specific checks: Total issues by severity
- List of passed waldronlab checks

### 11. Suggest Next Steps

Based on validation results:

**If PASS**:
- "All checks passed! This skill meets repository standards."
- "Ready to commit or submit for review"
- Optionally suggest running tests or checking SKILLS.md entry

**If FAIL**:
- "Please address the issues above before committing"
- For critical issues: "These must be fixed for the skill to work properly"
- For warnings: "These should be fixed to meet quality standards"
- For info: "These are optional improvements"
- Offer to help fix the issues

## Output Format

Generate a validation report in markdown format:

```markdown
# Skill Validation Report: [skill-name]

**Status**: ✅ PASS | ❌ FAIL ([N] issues)
**File**: skills/[skill-name]/SKILL.md
**Validated**: [timestamp]

---

## Generic Validation (markdownlint/yamllint)

**markdownlint**: ✅ PASS | ⚠️ [N] warnings
**yamllint**: ✅ PASS | ❌ FAIL

_Optional: Install markdownlint and yamllint for enhanced checking._

---

## Waldronlab-Specific Validation

### CRITICAL Issues (Must Fix)

❌ **[Issue title]** ([location])
   - Issue: [What violates standards]
   - Fix: [How to fix it]
   - Reference: [AGENTS.md or SKILL_STANDARD.md section]

### WARNING Issues (Should Fix)

⚠️ **[Issue title]** ([location])
   - Issue: [What should be improved]
   - Fix: [Recommendation]

### INFO Issues (Optional Improvements)

ℹ️ **[Issue title]** ([location])
   - Issue: [Optional improvement]
   - Fix: [Suggestion]

---

## Validation Summary

**Waldronlab-Specific Checks**:
- [List of checks with ✅ pass or ❌ fail status]

**Total**: [N] CRITICAL, [N] WARNING, [N] INFO

---

## Next Steps

[Recommendations based on pass/fail status]
```

## Examples

### Example 1: Validating a Skill in Current Directory

**User**: "Validate this skill"

**Agent**:
1. Checks if current directory contains SKILL.md
2. Optionally runs markdownlint and yamllint (if installed)
3. Reads file and performs waldronlab-specific validation
4. Generates detailed report with any issues found
5. Suggests fixes for each issue

**Output**: Two-phase validation report with generic and waldronlab-specific results

### Example 2: Validating by Skill Name

**User**: "Check if the analyze-r-package skill meets standards"

**Agent**:
1. Locates `skills/analyze-r-package/SKILL.md`
2. Performs all validation checks
3. Reports results

**Output**: Validation report for analyze-r-package

### Example 3: Quick Validation Check

**User**: "Does skills/create-skill/SKILL.md conform to standards?"

**Agent**:
1. Reads specified file
2. Runs all validations
3. Reports pass/fail with any issues

**Output**: Concise report focusing on any failures

### Example 4: Pre-commit Validation

**User**: "Validate all my changes to skills before I commit"

**Agent**:
1. Identifies modified skill files in git status
2. Validates each modified skill
3. Provides summary report

**Output**: Multi-skill validation report

## Platform-Specific Notes

This skill works across platforms (Claude Code, GitHub Copilot, etc.).

**CI/CD Integration**:
- Can be invoked programmatically in GitHub Actions
- Fails PR if validation fails
- Provides actionable feedback in PR comments

Platform-specific shortcuts are documented in instructions/{agent}.md.

## Notes

### Architecture: Generic + Waldronlab-Specific

This skill uses a two-phase validation approach:

1. **Generic Validation** (delegated to existing tools):
   - Uses `markdownlint` for markdown formatting
   - Uses `yamllint` for YAML syntax
   - These are standard, well-maintained tools we don't need to duplicate

2. **Waldronlab-Specific Validation** (this skill's focus):
   - Checks agent-agnostic compliance (AGENTS.md)
   - Validates waldronlab field requirements (SKILL_STANDARD.md)
   - Detects platform-specific language
   - Ensures naming conventions

This separation reduces maintenance burden—we don't reinvent markdown/YAML validation, only enforce waldronlab standards.

### Using This Skill

- **Validation is strict but helpful**: The goal is to catch issues early and provide clear guidance
- **Standards evolve**: Update this skill when SKILL_STANDARD.md or AGENTS.md change
- **Not a replacement for human review**: Validation catches structural/format issues but doesn't assess whether the skill logic makes sense
- **Complementary to testing**: Validation checks format; testing checks functionality
- **Use before committing**: Running validation before submitting PRs saves review time
- **Generic validators are optional**: The skill works without markdownlint/yamllint, but they provide enhanced checking

## Related Skills

- **create-skill**: Use to create a new skill that follows standards from the start
- **check-waldronlab-skills**: Discover and list available skills
- **SKILL_STANDARD.md**: Reference document for technical format specification
- **AGENTS.md**: Reference document for agent behavior and compliance rules

---

**See also**: [SKILL_STANDARD.md](../../SKILL_STANDARD.md), [AGENTS.md](../../AGENTS.md), [CONTRIBUTING.md](../../CONTRIBUTING.md)
