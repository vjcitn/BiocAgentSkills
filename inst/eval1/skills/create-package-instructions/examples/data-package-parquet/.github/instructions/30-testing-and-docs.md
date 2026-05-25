---
title: Testing and Documentation Guidance
topics: [roxygen, examples, testing, documentation]
---

# Testing and Documentation Guidance

For complete standards, see:
- [Core Bioconductor standards](https://github.com/waldronlab/ai-agent-skills/blob/main/r-packages/templates/bioconductor-development.md) - Documentation and testing requirements
- [Waldronlab conventions](https://github.com/waldronlab/ai-agent-skills/blob/main/r-packages/templates/waldronlab-standards.md) - Documentation and testing practices

## Development and Checking Commands

```bash
R CMD build .
R CMD check parkinsonsMetagenomicData_*.tar.gz
R -e "BiocCheck::BiocCheck('parkinsonsMetagenomicData_*.tar.gz')"
R -e "roxygen2::roxygenize()"
R -e "rmarkdown::render('vignettes/codebook.Rmd')"
R CMD INSTALL .
```

## Package-Specific Considerations

Standard checks (see Core Bioconductor standards linked above) plus:
- Verify vignettes knit successfully (this package has 5 vignettes)
- Test parquet file access with local test data
- Confirm UUID validation works correctly

## Package-Specific Testing

### Test Data
- **Location**: Small local files in `inst/extdata/`
- **File types**: Representative parquet, TSV/TXT, and RDS test files
- **Remote testing**: Tests avoid remote dependencies where possible; use local alternatives

### Testing Focus Areas
- Invalid input and error handling
- UUID validation patterns
- Parquet column structure verification
- TreeSummarizedExperiment output format

## Package-Specific Documentation

### Examples Approach
- Include at least one runnable example per exported function
- Use `\donttest{}` for examples requiring network access or that may hit rate limits
- Always provide a local alternative using test data when network examples exist
- **Never** use `\dontrun{}` - if it can't run, provide a local alternative

## Before considering a change complete
- Run `roxygen2::roxygenize()` if docs changed
- Verify examples still work
- Check that exported functions have tests
- Verify vignettes knit successfully
- Follow the complete checklist in the Core Bioconductor standards
