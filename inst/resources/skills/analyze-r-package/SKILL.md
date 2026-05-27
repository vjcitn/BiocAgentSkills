---
name: analyze-r-package
description: Analyze R/Bioconductor package structure to extract key information about its purpose, exports, and characteristics
version: 1.0.0
category: r-packages
tags: [r-packages, analysis, bioconductor, documentation]
author: waldronlab
---

# analyze-r-package

Analyze an R/Bioconductor package to understand its structure, purpose, and key characteristics.

## Usage

Invoke this skill when you want to understand an R package's architecture:
- "Analyze this R package"
- "What type of R package is this?"
- "Tell me about this package structure"
- "Examine this R package"

You must be in an R package directory (contains DESCRIPTION file) for this skill to work.

## Prerequisites

- Working directory is an R package root (contains DESCRIPTION file)
- Package has standard R structure (R/, NAMESPACE, etc.)
- You have read access to package files

## Process

### 1. Read Package Metadata

Read and analyze the DESCRIPTION file to extract:

- **Package name**: From `Package` field
- **Title**: From `Title` field (one-line summary)
- **Description**: From `Description` field (detailed explanation)
- **Version**: From `Version` field
- **Type classification**: Analyze `biocViews` field for keywords:
  - "ExperimentData", "ExpressionData", etc. → **Data Package**
  - "StatisticalMethod", "Workflow" → **Analysis Package**
  - "Infrastructure", "DataRepresentation" → **Infrastructure Package**
  - Otherwise → **Utility Package**
- **Key dependencies**: Parse `Imports` and `Depends` fields, especially noting:
  - SummarizedExperiment / TreeSummarizedExperiment
  - ExperimentHub / AnnotationHub
  - Database packages (DBI, DuckDB, RSQLite)
  - Remote data packages (httr2, aws.s3)

### 2. Identify Exported Functions

Read and parse the NAMESPACE file to extract all exports:

Extract lines starting with:
- `export(...)` - Regular function exports
- `exportClasses(...)` - S4 class exports
- `exportMethods(...)` - S4 method exports

Categorize functions by naming patterns:
- **Data access functions**: Names containing `get`, `load`, `retrieve`, `fetch`, `access`, `return`
- **Data processing functions**: Names containing `filter`, `subset`, `aggregate`, `transform`
- **Utility functions**: Names containing `validate`, `check`, `confirm`
- **Visualization functions**: Names containing `plot`, `draw`, `show`

Count totals for each category.

### 3. Examine Directory Structure

Check which directories exist and their contents:

Note presence of:
- **data/**: R data objects (RDA files)
- **inst/extdata/**: Raw data files
- **vignettes/**: Count `.Rmd` files
- **tests/testthat/**: Testing framework files
- **src/**: Compiled code (C/C++)

### 4. Detect Data Access Patterns

Search R source files (in `R/` directory) for data access indicators:

- **"ExperimentHub"** → ExperimentHub integration
- **"AnnotationHub"** → AnnotationHub integration
- **"dbConnect"** OR **"DuckDB"** → Database access
- **"download.file"** OR **"curl"** → Direct URL downloads
- **"aws.s3"** OR **"bucket"** → AWS S3 access
- **"huggingface"** → HuggingFace datasets
- **"parquet"** → Parquet file handling
- **"hdf5"** OR **"h5"** → HDF5 file handling

If matches found, classify as having **remote data access**.

Classify data access type:
- **None**: No data access functions
- **Local Only**: Only `data/` or `inst/extdata/`
- **Remote**: Only remote access (ExperimentHub, URLs, S3, etc.)
- **Hybrid**: Both local and remote access patterns

### 5. Identify S4 Classes

Search R source files for S4 class definitions:

Look for:
- `setClass(`
- `methods::setClass(`
- `setMethod(`
- `setGeneric(`

List any S4 classes defined in the package with their slots if visible.

### 6. Read README

Read the README.md file (first 500 lines if very long) to extract:

- **High-level purpose**: Usually first few paragraphs
- **Key features**: Often in a bulleted list
- **Links to data sources**: URLs for external resources
- **Example usage patterns**: Code examples showing typical use

### 7. Analyze Testing

Check test structure:

- List all files matching `tests/testthat/test-*.R`
- Note number of test files
- Check `inst/extdata/` for test data files and their types
- Determine if tests use remote resources (look for ExperimentHub, downloads in test files)

### 8. List Vignettes

If vignettes directory exists, for each `.Rmd` file:

- Read first 50 lines to identify title and purpose
- Extract YAML frontmatter `title:` field
- Note the vignette filename

Create a list with vignette names and their purposes.

## Output Format

Produce a structured markdown summary:

```markdown
## Package Analysis: [Package Name]

### Classification
- **Type**: [Data/Analysis/Infrastructure/Utility] Package
- **Purpose**: [1-2 sentence summary from DESCRIPTION and README]
- **Version**: [version number]

### Key Exports ([count] total)

**Data Access Functions** ([count]):
- `function1()` - [brief description if available]
- `function2()` - [brief description if available]

**Data Processing Functions** ([count]):
- `function3()` - [brief description if available]

**Utility Functions** ([count]):
- `function4()` - [brief description if available]

[Other categories as needed]

### Data Access Pattern
- **Type**: [None / Local Only / Remote / Hybrid]
- **Sources**: [List if applicable]
  - [Source 1]: [URL or location]
  - [Source 2]: [URL or location]
- **Technologies**: [e.g., ExperimentHub, DuckDB, direct URLs]

### S4 Classes
[If none: "No S4 classes defined"]
[If present:]
- `ClassName1` - [description if available]
- `ClassName2` - [description if available]

### Documentation

**Vignettes** ([count]):
1. [vignette-name.Rmd] - [Purpose/Title]
2. [vignette-name.Rmd] - [Purpose/Title]

**Testing**:
- Framework: [testthat / other / none]
- Test files: [count]
- Test data: [location and types]

### Special Characteristics
[List notable patterns that should be documented]

### Dependencies of Note
[List key Bioconductor or specialized packages and why they matter]
```

## Error Handling

**If required files don't exist**:
- **DESCRIPTION missing** → "Not an R package directory"
- **NAMESPACE missing** → "No NAMESPACE found - package may not be built yet"
- **No R/ directory** → "No R source files found"

**If directory structure is unclear**:
- Ask: "Is this a data package, analysis package, or infrastructure package?"
- Explain what was found and why classification is ambiguous

## Examples

### Example 1: Data Package Analysis

For parkinsonsMetagenomicData:

```markdown
## Package Analysis: parkinsonsMetagenomicData

### Classification
- **Type**: Data Package
- **Purpose**: Provides uniformly processed gut microbiome data from Parkinson's Disease studies via remote parquet files accessed through DuckDB.
- **Version**: 0.99.0

### Key Exports (18 total)

**Data Access Functions** (5):
- `returnSamples()` - Main high-level data retrieval function
- `accessParquetData()` - Setup DuckDB connection to remote parquet files
- `loadParquetData()` - Load filtered data from DuckDB connection
- `load_ref()` - Load reference lookup tables
- `db_connect()` - Create DuckDB database connection

**Discovery Functions** (5):
- `parquet_colinfo()` - Inspect column structure of data types
- `get_hf_parquet_urls()` - Get HuggingFace parquet file URLs
- `get_repo_info()` - List available HuggingFace repositories
- `get_ref_info()` - List available reference tables
- `biobakery_files()` - List available data types with descriptions

### Data Access Pattern
- **Type**: Hybrid (Remote primary, Local for testing)
- **Sources**:
  - HuggingFace: waldronlab/metagenomics_mac (full dataset)
  - HuggingFace: waldronlab/metagenomics_mac_examples (example subset)
  - Local: inst/extdata/ (test fixtures)
- **Technologies**: DuckDB for remote parquet access, TreeSummarizedExperiment output

### Documentation

**Vignettes** (5):
1. codebook.Rmd - Data Codebook: reference for all variables
2. first-15-minutes.Rmd - Quick start guide for new users
3. full-workflow.Rmd - Comprehensive tutorial with multiple data types
4. piecewise-workflow.Rmd - Advanced direct database control patterns

**Testing**:
- Framework: testthat
- Test files: 3
- Test data: inst/extdata/ (parquet, TSV, RDS files)

### Special Characteristics
- Uses DuckDB for efficient remote parquet file querying without full download
- Multiple data types: taxonomic (MetaPhlAn), functional (HUMAnN), QC (FastQC)
- Large file handling requires sorted column filtering strategies
```

## Integration

This analysis output is consumed by:
- `create-package-instructions` - For initial instruction generation
- `update-package-instructions` - For updating existing instructions
- General package understanding and development assistance

## Notes

- Manual verification recommended for complex packages
- Ask for clarification rather than guessing when ambiguous
- Output designed for use by other skills (e.g., `create-package-instructions`) or user understanding

See [SKILL_STANDARD.md](../../SKILL_STANDARD.md) for format details and [create-package-instructions](../create-package-instructions/SKILL.md) for how to use this analysis.
