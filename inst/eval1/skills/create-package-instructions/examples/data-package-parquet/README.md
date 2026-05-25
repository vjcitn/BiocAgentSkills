parkinsonsMetagenomicData
================

<!-- badges: start -->
[![R CMD Check + BiocCheck](https://github.com/ASAP-MAC/parkinsonsMetagenomicData/actions/workflows/pr_check.yml/badge.svg)](https://github.com/ASAP-MAC/parkinsonsMetagenomicData/actions/workflows/pr_check.yml)
[![Codecov test coverage](https://codecov.io/gh/ASAP-MAC/parkinsonsMetagenomicData/branch/devel/graph/badge.svg)](https://app.codecov.io/gh/ASAP-MAC/parkinsonsMetagenomicData?branch=devel)
<!-- badges: end -->

# Package Overview

This package provides access to uniformly processed gut microbiome data from Parkinson's Disease studies. The gut-brain axis has emerged as an important factor in Parkinson's Disease, with multiple studies identifying differences in the gut microbiome composition between individuals with Parkinson's and healthy controls.

**What data is available?**

This package provides comprehensive microbiome profiling data from fecal samples, including:

- **Microbial composition**: Which bacteria, viruses, and other microorganisms are present and their relative abundances
- **Bacterial strain identification**: Fine-resolution tracking of specific bacterial strains
- **Functional profiles**: What genes and metabolic pathways are encoded by the gut microbiome
- **Quality metrics**: Technical information about sequencing depth and data quality

All data have been uniformly processed through the [curatedMetagenomicsNextflow](https://github.com/seandavi/curatedMetagenomicsNextflow) pipeline using standardized bioinformatics tools (MetaPhlAn, StrainPhlAn, HUMAnN, FastQC, KneadData) to ensure consistency across studies.

For additional analysis utilities including taxonomic handling and statistical tests, see [biobakeryUtils](https://github.com/g-antonello/biobakeryUtils/tree/main).

## Available Data

The ASAP-MAC initiative has collected a number of Parkinson's Disease-focused
studies for metadata curation, uniform processing, and meta-analysis. The
ongoing process of the collection of these datasets can be followed in the
[parkinsons_data_search](https://github.com/ASAP-MAC/parkinsons_data_search)
repository. The majority of the studies listed in the table
[parkinson_shotgun_datasets.tsv](https://github.com/ASAP-MAC/parkinsons_data_search/blob/main/parkinson_shotgun_datasets.tsv)
are available for retrieval with this package.

To browse the available data, load the `sampleMetadata` object included in this
package. To see which data types are available in the remote repositories, use
`get_repo_info()` and `get_hf_parquet_urls()`. See the vignettes for examples.

### Sample Metadata

Metadata for all samples is available through the `sampleMetadata` data frame,
which includes curated clinical and demographic information (identifiers, age,
sex, disease status, study design) as well as uncurated features (prefixed with
"uncurated_"). The curation process can be seen in more detail in the
[parkinsonsManualCuration](https://github.com/ASAP-MAC/parkinsonsManualCuration)
repository. For complete variable definitions, allowed values, and column
descriptions, see the
[Data Codebook vignette](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/codebook.html).

### Data Types

Data are organized into several categories based on biological content:

**Taxonomic Composition** (MetaPhlAn outputs)
- `relative_abundance`: Relative abundance of bacterial, archaeal, viral, and eukaryotic species
- `viral_clusters`: Viral community composition
- `marker_abundance`, `marker_presence`: Species-specific genetic markers for taxonomic identification

**Strain-Level Profiling** (StrainPhlAn outputs)
- `strainphlan_markers`: Strain-specific genetic markers for tracking bacterial variants

**Functional Profiling** (HUMAnN outputs)
- `genefamilies_*`: Abundance of gene families (groups of related genes)
- `pathabundance_*`: Abundance of metabolic pathways (e.g., carbohydrate metabolism, amino acid synthesis)
- `pathcoverage_*`: Coverage/completeness of metabolic pathways

*Normalization options:* Raw counts, relative abundance (relab), or copies per million (cpm); some data are stratified by contributing species, others are community totals (unstratified).

**Quality Control**
- `fastqc`: Sequencing quality metrics (read quality, GC content, adapter contamination)
- `kneaddata_log`: Pre-processing statistics (human DNA removal, quality filtering)

## Data Hosting

While the sample metadata are available within this package, the various output
files are hosted remotely due to their size and number. There are therefore two
options for data retrieval.

### Google Cloud Storage (Developer Access)

The raw pipeline outputs are stored in the Google Cloud Bucket `gs://metagenomics-mac`, which requires credentials for access. This is primarily for developers and maintainers who need to access individual sample files directly from the pipeline. Most users should use the Hugging Face repository instead (see below).

For developers: Once authenticated, data are organized as individual files for each sample and output type, and can be downloaded with requester-pays GCP egress fees. The [parquet_generation](https://github.com/ASAP-MAC/parquet_generation) repository contains scripts for transforming these raw outputs into the consolidated parquet files.


### Hugging Face (Recommended)

For most users, the data have been combined into parquet files (see this process in the [parquet_generation](https://github.com/ASAP-MAC/parquet_generation) repository) and hosted publicly on Hugging Face in the [metagenomics_mac repo](https://huggingface.co/datasets/waldronlab/metagenomics_mac). Smaller example files featuring data from 10 samples each can be found at [metagenomics_mac_examples](https://huggingface.co/datasets/waldronlab/metagenomics_mac_examples).

These files can be easily accessed through the [DuckDB R client](https://duckdb.org/docs/stable/clients/r.html). The package provides convenient wrapper functions documented in the vignettes:

- [First 15 Minutes](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/first-15-minutes.html) - Quick start guide
- [Full Workflow](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/full-workflow.html) - Comprehensive data retrieval
- [Piecewise Workflow](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/piecewise-workflow.html) - Advanced database control
- [Working with Large Parquet Files](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/working-with-large-parquet-files.html) - Strategies for large data types
- [Data Codebook](https://asap-mac.github.io/parkinsonsMetagenomicData/articles/codebook.html) - Complete variable definitions

## Linked Repositories

