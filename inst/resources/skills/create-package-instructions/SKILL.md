---
name: create-package-instructions
description: Create complete AI instruction documentation for an R/Bioconductor package in .github/instructions/
version: 1.0.0
category: r-packages
tags: [r-packages, documentation, bioconductor]
author: waldronlab
---

# create-package-instructions

Create complete AI instruction documentation for an R/Bioconductor package in `.github/instructions/`.

## Usage

Invoke this skill when you want to generate AI-friendly documentation for an R package:
- "Create instructions for this package"
- "Generate AI documentation"
- "Create .github/instructions for this R package"
- "Set up instructions for this package"

You must be in an R package directory (contains DESCRIPTION file) for this skill to work.

## Prerequisites

- Working directory is an R package root (contains DESCRIPTION file)
- Package has standard R structure (R/, NAMESPACE, etc.)
- Target directory `.github/instructions/` will be created if it doesn't exist

## Process

### 1. Run Package Analysis

First, analyze the package to understand its structure.

**Action**: Run the `analyze-r-package` skill to produce a complete package analysis.

This provides the structured information needed to determine which instruction files to create and what content to include.

### 2. Determine Required Instruction Files

Based on the analysis output, determine which templates to use:

| Template | Condition | Output File |
|----------|-----------|-------------|
| `00-overview.md.template` | Always | `00-overview.md` |
| `10-data-access.md.template` | Type: Remote or Hybrid | `10-data-access.md` |
| `20-development.md.template` | Always | `20-development.md` |
| `30-testing-and-docs.md.template` | Always | `30-testing-and-docs.md` |
| `40-vignettes.md.template` | Vignettes > 0 | `40-vignettes.md` |
| `INDEX.md.template` | Always | `INDEX.md` |

### 3. Create `.github/instructions/` Directory

If the directory doesn't exist, create it:
- Ensure `.github/` parent directory exists
- Create `instructions/` subdirectory

### 4. Create Instruction Files from Templates

For each required template:

1. **Read template** from `templates/package-instructions/[filename].template`
2. **Perform variable substitution** using analysis output (see `templates/package-instructions/README.md` for variable mappings)
3. **Write result** to `.github/instructions/[filename].md`

Variable substitution process:
- Extract all `{{VARIABLE_NAME}}` placeholders from template
- Map variables to analysis output using the mapping table in template README
- Replace placeholders with actual values
- For optional variables, use `[To be documented]` if value unavailable
- For conditional sections (e.g., `{{CONDITIONAL_DATA_ACCESS}}`), remove line if condition false

See `templates/package-instructions/README.md` for:
- Complete variable mapping table
- Substitution rules and examples
- Conditional handling

### 5. Update Package Files

#### .gitignore

Check that `.github/instructions/` is NOT ignored (instructions should be committed).

#### .Rbuildignore

Add entry to prevent instructions from being included in package build:

```
^\.github/instructions$
```

If `.Rbuildignore` doesn't exist, create it with this line.

### 6. Provide Summary

After creating all files, provide:
- Files created
- Functions documented (count)
- Data access patterns (if applicable)
- Vignettes (count, if applicable)
- Next steps for customization

## Integration

**This skill uses**:
- `analyze-r-package` - To gather package information

**This skill is used by**:
- Users manually when setting up new packages
- Can be called from other orchestration workflows

**Works with**:
- `update-package-instructions` - For updating existing instructions

## Error Handling

- **Analysis fails**: Propagate error, provide guidance
- **Directory creation fails**: Check permissions
- **Instructions exist**: Ask user to overwrite or use `update-package-instructions`
- **Template not found**: Verify templates directory exists at `templates/package-instructions/`

## Notes

- Templates define structure; analysis provides content
- Ask before overwriting existing files
- Generated content is a starting point for customization
- See `templates/package-instructions/README.md` for template documentation

---

**Related**: See [analyze-r-package](../analyze-r-package/SKILL.md) for package analysis skill, [update-package-instructions](../update-package-instructions/SKILL.md) for updating existing instructions.
