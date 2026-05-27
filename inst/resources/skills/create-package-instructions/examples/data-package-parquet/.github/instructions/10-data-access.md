---
title: Data Access Guidance
topics: [returnSamples, accessParquetData, loadParquetData, filtering, performance]
---

# Data Access Guidance

## Preferred access patterns

### Use `returnSamples()`
Use this when the user wants:
- quick access without complex filtering
- metadata-based filtering first
- immediate `TreeSummarizedExperiment` output

Example:
```r
my_samples <- sampleMetadata %>% dplyr::filter(age >= 18)

tse <- returnSamples(
  sample_data = my_samples,
  data_type = "relative_abundance"
)
```

### Use `accessParquetData()` + `loadParquetData()`
Use this when the user needs:
- feature-level filtering before loading
- direct DuckDB queries
- custom SQL-like operations
- memory-efficient loading of large files

Example:
```r
con <- accessParquetData(data_types = "relative_abundance")

tse <- loadParquetData(
  con,
  data_type = "relative_abundance",
  filter_values = list(
    clade_name_species = c("s__Escherichia_coli")
  )
)
```

## Large file strategy
For `genefamilies_stratified` and similarly large files:
1. Filter first on sorted columns such as `uuid`, `gene_family_uniref`, and `pathway`
2. Use two-stage filtering: remote sorted-column filter, then local filtering
3. Consider downloading files locally for repeated queries
4. See detailed examples in the "Working with Large Parquet Files" vignette (refer to [40-vignettes.md](40-vignettes.md))

## Useful helper functions
- `parquet_colinfo(data_type)` — inspect column structure
- `get_hf_parquet_urls()` — obtain parquet file URLs
- `load_ref()` — load reference lookup tables
- `db_connect()` — create a DuckDB connection