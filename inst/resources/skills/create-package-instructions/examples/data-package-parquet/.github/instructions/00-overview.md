---
title: Overview
topics: [package-overview, data-sources, key-functions, navigation]
---

# Overview

This directory contains AI agent guidance for the parkinsonsMetagenomicData R package. These instructions help agents understand package structure, coding standards, and workflows.

## Navigation Guide

Read these files for complete context:
- **[00-overview.md](00-overview.md)** (this file) - Package overview and key resources
- **[10-data-access.md](10-data-access.md)** - Data retrieval patterns and strategies
- **[20-development.md](20-development.md)** - Coding standards and best practices
- **[30-testing-and-docs.md](30-testing-and-docs.md)** - Testing and documentation requirements
- **[40-vignettes.md](40-vignettes.md)** - Vignette purposes and update guidance

## Key Data Access Functions

### `returnSamples()`
Quick access to filtered data with immediate TreeSummarizedExperiment output.
- Use when: Simple metadata-based filtering
- Returns: TreeSummarizedExperiment object
- See: [10-data-access.md](10-data-access.md#use-returnsamples)

### `accessParquetData()` + `loadParquetData()`
Advanced querying with feature-level filtering and direct DuckDB access.
- Use when: Complex filtering, SQL operations, memory-efficient loading
- Returns: Database connection and TreeSummarizedExperiment
- See: [10-data-access.md](10-data-access.md#use-accessparquetdata--loadparquetdata)

### Helper Functions
- `parquet_colinfo(data_type)` - Inspect column structure before coding
- `get_hf_parquet_urls()` - Obtain parquet file URLs
- `load_ref()` - Load reference lookup tables
- `db_connect()` - Create DuckDB connection

## Data Sources

### HuggingFace Repositories
- **Full dataset**: [waldronlab/metagenomics_mac](https://huggingface.co/datasets/waldronlab/metagenomics_mac)
  - Complete combined parquet files for production analyses
- **Example dataset**: [waldronlab/metagenomics_mac_examples](https://huggingface.co/datasets/waldronlab/metagenomics_mac_examples)
  - Smaller files with 10 samples each for testing and demonstrations

### Local Test Data
- **inst/extdata/** - Small offline examples for package testing
- Used in test suite and examples that don't require network access

## Package Structure

This package provides access to Parkinson's disease metagenomic data from the Michael J. Fox Foundation's ASAP MAC consortium. Data are stored as parquet files and accessed remotely or locally via DuckDB.

### Key Design Principles
- Return TreeSummarizedExperiment objects for compatibility with Bioconductor
- Support both simple and advanced filtering patterns
- Enable memory-efficient queries on large files
- Provide reference data for feature annotations

## Quick Start

For detailed guidance on specific topics, see the linked instruction files above.