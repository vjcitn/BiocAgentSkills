---
name: update-package-instructions
description: Update existing AI instruction documentation when an R/Bioconductor package changes
version: 1.0.0
category: r-packages
tags: [r-packages, documentation, bioconductor]
author: waldronlab
---

# update-package-instructions

Update existing `.github/instructions/` files when an R/Bioconductor package changes, preserving manual customizations.

## Usage

Invoke this skill when your package has changed and you want to refresh the AI instructions:
- "Update the package instructions"
- "Refresh AI documentation"
- "Update instructions based on package changes"
- "Sync instructions with current package state"

You must have existing `.github/instructions/` files for this skill to work.

## Prerequisites

- Working directory is an R package root (contains DESCRIPTION file)
- Existing instructions exist at `.github/instructions/`
- Instructions were previously generated or created

## Process

### 1. Run Package Analysis

Analyze the current package state.

**Action**: Run the `analyze-r-package` skill to produce a complete current package analysis.

This provides the current package structure and characteristics.

### 2. Read Existing Instructions

Read all existing instruction files in `.github/instructions/`:

For each `.md` file:
- Read the complete content
- Note the structure and sections
- Identify manually-added content (domain explanations, specific examples, warnings)
- Extract key documented information (version numbers, function lists, etc.)

### 3. Identify Changes

Compare current package analysis to documented state:

**Change categories**:
- **Metadata**: Version, description, dependencies, biocViews
- **Structure**: New/removed/renamed functions, vignettes, S4 classes, test files
- **Content**: Data sources, access patterns, examples

### 4. Determine Update Scope

For each instruction file, check if template variables have changed:

1. Read template from `templates/package-instructions/[filename].template`
2. Extract template variables (all `{{VARIABLE_NAME}}` placeholders)
3. Compare variable values: current analysis vs. existing documentation
4. If any variable differs, file needs update

See `templates/package-instructions/README.md` for:
- Template variable mappings
- Update trigger rules by file

### 5. Update Strategy

**Preserve custom content**:
- Domain explanations, examples, warnings, author notes
- Detect: Multi-sentence paragraphs not matching template structure

**Update systematically**:
- **Version numbers**: Find-replace across all files
- **Function lists**: Add new with `[Description needed]`, remove deleted, preserve custom descriptions
- **Sections**: Targeted edits, not wholesale replacement

**Mark changes** (optional):
```markdown
<!-- Auto-updated 2026-04-03: Added new function -->
```

### 6. Apply Updates

For each file with changed variables:
- Make targeted edits to update variable values
- Preserve surrounding custom content
- Verify cross-references after changes

### 7. Provide Update Summary

Report:
- Changes detected
- Files updated
- Customizations preserved
- Items needing manual review

## Error Handling

- **No instructions found**: Direct to `create-package-instructions`
- **No changes detected**: Report up-to-date status
- **Conflicts**: Prompt for keep/replace/merge decision
- **Format mismatch**: Offer skip/attempt/regenerate options
- **Template not found**: Verify `templates/package-instructions/` exists

## Integration

**This skill uses**:
- `analyze-r-package` - To get current package state

**This skill is used by**:
- Users manually when package changes

**Works with**:
- `create-package-instructions` - For initial creation

## Notes

- Preserve customizations unless user requests overwrite
- Use template structure to identify what changed
- Verify cross-references after updates
- See `templates/package-instructions/README.md` for update rules

---

**Related**: See [create-package-instructions](../create-package-instructions/SKILL.md) for creating new instructions, [analyze-r-package](../analyze-r-package/SKILL.md) for package analysis.
