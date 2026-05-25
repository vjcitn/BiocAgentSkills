---
title: Instruction Files Index
topics: [navigation, index, discovery, organization]
---

# Instruction Files Index

This directory contains modular guidance for AI agents working with the parkinsonsMetagenomicData R package.

## Reading Order

For complete context, read these files in order:

1. **[00-overview.md](00-overview.md)** - Package overview, key functions, and data sources
2. **[10-data-access.md](10-data-access.md)** - Data retrieval patterns and filtering strategies
3. **[20-development.md](20-development.md)** - Coding standards and parquet structure
4. **[30-testing-and-docs.md](30-testing-and-docs.md)** - Testing requirements and documentation standards
5. **[40-vignettes.md](40-vignettes.md)** - Vignette purposes and update guidelines

## Quick Reference by Topic

### Data Access
- **Simple filtering**: [10-data-access.md](10-data-access.md#use-returnsamples) - `returnSamples()`
- **Advanced querying**: [10-data-access.md](10-data-access.md#use-accessparquetdata--loadparquetdata) - `accessParquetData()` + `loadParquetData()`
- **Large files**: [10-data-access.md](10-data-access.md#large-file-strategy)
- **Data sources**: [00-overview.md](00-overview.md#data-sources) - HuggingFace repos and local data

### Development
- **Coding standards**: [20-development.md](20-development.md#coding-standards)
- **Column roles**: [20-development.md](20-development.md#column-roles-in-parquet-files)
- **Package suggestions**: [20-development.md](20-development.md#when-to-suggest-package-changes)

### Testing & Documentation
- **Documentation requirements**: [30-testing-and-docs.md](30-testing-and-docs.md#documentation-requirements-for-exported-functions)
- **Example guidelines**: [30-testing-and-docs.md](30-testing-and-docs.md#examples)
- **Testing standards**: [30-testing-and-docs.md](30-testing-and-docs.md#testing-standards)

### Vignettes
- **Vignette purposes**: [40-vignettes.md](40-vignettes.md#existing-vignette-purposes)
- **Update guidelines**: [40-vignettes.md](40-vignettes.md#when-updating-vignettes)


## File Organization

Files are numbered to indicate recommended reading order:
- **00-** - Overview and navigation
- **10-20** - Core functionality and development
- **30-40** - Quality assurance and documentation
- **50+** - Workflows and processes

Each file includes:
- YAML frontmatter with title and topic tags
- Cross-references to related files
- Focused, actionable guidance on specific topics
