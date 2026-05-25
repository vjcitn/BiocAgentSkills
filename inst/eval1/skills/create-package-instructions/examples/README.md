# R Package Instruction Examples

This directory contains real-world examples of `.github/instructions/` generated for waldronlab packages. These serve as:

- **Reference implementations** - See what good instructions look like
- **Testing baselines** - Validate that skills produce similar output
- **Templates** - Copy and adapt for similar package types
- **Documentation** - Understand how instructions adapt to different packages

## Examples

### data-package-parquet/ (parkinsonsMetagenomicData)

**Package Type**: Data Package
**Pattern**: Remote parquet files accessed via DuckDB
**Repository**: https://github.com/waldronlab/parkinsonsMetagenomicData

**Key Characteristics**:
- Remote data access via HuggingFace datasets
- Large file handling strategies required
- Multiple data types (taxonomic, functional, QC)
- 5 vignettes for different audiences
- DuckDB-based filtering patterns

**Instructions Included**:
- ✅ 00-overview.md - Package overview with data sources
- ✅ 10-data-access.md - Data retrieval patterns (returnSamples vs accessParquetData)
- ✅ 20-development.md - Coding standards and parquet structure
- ✅ 30-testing-and-docs.md - Testing with local fixtures
- ✅ 40-vignettes.md - 5 vignettes with distinct purposes
- ✅ INDEX.md - Navigation and quick reference

**What Makes This Example Notable**:
- Shows conditional data-access instructions for data packages
- Documents large file optimization strategies
- Multiple vignettes with clear audience targeting
- HuggingFace dataset integration pattern
- TreeSummarizedExperiment output format

**Files Included**:
```
data-package-parquet/
├── DESCRIPTION         # Package metadata for context
├── NAMESPACE          # Exported functions
├── README.md          # First 100 lines for package overview
└── .github/
    └── instructions/
        ├── INDEX.md
        ├── 00-overview.md
        ├── 10-data-access.md
        ├── 20-development.md
        ├── 30-testing-and-docs.md
        ├── 40-vignettes.md
```

---

## Future Examples (Planned)

### data-package-experimenthub/
**Pattern**: ExperimentHub data access
**Example**: curatedMetagenomicData

**Will demonstrate**:
- ExperimentHub metadata and hub resource creation
- Cache management patterns
- Version control for data updates

### analysis-package/
**Pattern**: Statistical methods and workflows
**Example**: MicrobiomeProfiler or microbiomeMarker

**Will demonstrate**:
- Method documentation patterns
- Workflow-focused instructions
- Input/output format specifications
- Common analysis pipelines

### infrastructure-package/
**Pattern**: S4 classes and core functionality
**Example**: TreeSummarizedExperiment-like package

**Will demonstrate**:
- S4 class structure documentation
- Constructor and accessor patterns
- Validation and coercion methods
- Extensibility guidance

---

## Using These Examples

### As Reference
When generating instructions for your package, compare against similar examples to ensure:
- Appropriate level of detail
- Relevant sections included
- Package-specific customizations present
- Cross-references working correctly

### For Testing
When updating the skills:

1. Delete generated instructions from example package
2. Run skills to regenerate
3. Compare output to these reference versions
4. Ensure quality is maintained or improved

### As Templates
If your package is similar to an example:

1. Copy the example instructions
2. Find-and-replace package-specific names
3. Update function names and descriptions
4. Customize sections for your package
5. Remove sections that don't apply

## Contributing Examples

To add a new example:

1. **Choose a representative package** from waldronlab
2. **Generate or copy instructions** that are high quality
3. **Create directory** following naming pattern: `{type}-{pattern}/`
4. **Include minimal context**:
   - DESCRIPTION
   - NAMESPACE
   - First ~100 lines of README.md
   - Complete .github/instructions/
5. **Add to this README** with description
6. **Submit PR**

### Example Quality Criteria

Good examples should:
- ✅ Represent a distinct pattern or package type
- ✅ Have complete, well-formatted instruction files
- ✅ Include package-specific customizations
- ✅ Follow current instruction format standards
- ✅ Have working cross-references
- ✅ Be from an actively maintained package

Avoid examples that:
- ❌ Are too similar to existing examples
- ❌ Are from deprecated or unmaintained packages
- ❌ Have minimal or generic instructions
- ❌ Contain sensitive information
- ❌ Are significantly outdated

## Updating Examples

Examples should be kept reasonably current:

- **When**: Instruction format changes significantly
- **How**: Regenerate using updated skills
- **Verify**: Compare to ensure improvements maintained
- **Document**: Note any format version in example description

## Questions?

If you're unsure which example applies to your package type, review:
1. Package DESCRIPTION biocViews
2. Primary exported functions
3. Data access patterns (if any)
4. Similar packages in waldronlab
5. GitHub Discussions for the ai-agent-skills repository
