---
name: security-audit-r-package
description: Perform comprehensive security audit of R/Bioconductor packages
version: 1.0.0
category: r-packages
tags: [security, bioconductor, quality-control, validation, audit]
author: waldronlab
---

# security-audit-r-package

Perform comprehensive security audits of R/Bioconductor packages, identifying vulnerabilities, native code security issues, code quality problems, and dependency risks. Generates standardized security reports for package maintainers to review before submission or release.

This skill analyzes R code, native code (C/C++/Fortran), dependencies, and package structure against security best practices. It's designed for package maintainers doing self-review before CRAN/Bioconductor submission or public release.

## Usage

Invoke this skill when you want to audit an R package for security issues:
- "Run security audit on this R package"
- "Check this package for security vulnerabilities"
- "Perform security review of this Bioconductor package"
- "Audit the security of this R package"

You can optionally specify a subset to audit:
- "Security audit only the R/ directory"
- "Review src/ for native code vulnerabilities"
- "Check [specific file] for security issues"

## Prerequisites

- Working directory is an R package (contains DESCRIPTION file)
- Package has standard R package structure
- For native code analysis: src/ directory with C/C++/Fortran code
- Internet access to fetch audit instructions from the reference gist

## Process

### 1. Determine Audit Scope

**Default scope** (comprehensive audit):
- `DESCRIPTION` - Package metadata and dependencies
- `NAMESPACE` - Exported functions and imports
- `R/` - All R source code files
- `src/` - Native code (C/C++/Fortran) if present

**User-specified scope** (optional):
- Specific directories (e.g., only `R/` or only `src/`)
- Specific files for targeted review
- Confirm scope with user if unclear

### 2. Fetch Security Audit Instructions

Read the standardized security audit instructions from:
**https://gist.github.com/lwaldron/0606c678e7d81b012a1b05901cf4b732**

These instructions define:
- Security vulnerability categories to check (SQL injection, command injection, path traversal, etc.)
- Native code security issues (buffer overflows, memory safety, unsafe functions, etc.)
- Code quality concerns (input validation, error handling, etc.)
- Dependency risks
- Standardized issue type labels (19 labels from SQL_INJECTION to OTHER)
- Required fields for each finding (issue type, severity, description, location, fix)

### 3. Read Package Files

Read all files in the audit scope:
- Read DESCRIPTION and NAMESPACE
- Recursively read all `.R` files in R/
- Recursively read all native code files in src/ (`.c`, `.cpp`, `.h`, `.f`, `.f90`, etc.)
- Collect complete source code for analysis

### 4. Analyze for Security Issues

Review the code against the security checklist defined in the audit instructions (from the gist). The instructions specify categories including:
- Security vulnerabilities (SQL injection, command injection, path traversal, unsafe deserialization, etc.)
- Native code security issues (buffer overflows, memory safety, unsafe functions, etc.)
- Code quality concerns (input validation, error handling, deprecated functions, etc.)
- Dependency risks

Refer to the gist for the complete and authoritative list of security checks to perform.

### 5. Generate Security Report

Create a report with findings from the analysis. The gist defines the required fields for each issue:
- **Issue Type Label**: One of the 19 standardized labels from the gist
- **Severity**: Critical, High, Medium, or Low
- **Description**: Explanation of the security issue
- **Location**: File and line/function reference
- **Recommended Fix**: Specific remediation guidance

**Format flexibility:**
- For comprehensive audits: Use structured markdown with summary, severity breakdown, and detailed findings sections
- For quick reviews: Concise list format
- For single-file checks: Brief inline feedback
- Adapt output verbosity and structure to the context

**Structured format example** (for full package audits):
```markdown
# Security Audit Report: [Package Name]

**Date**: [ISO date]
**Package Version**: [from DESCRIPTION]
**Scope**: [audited files/directories]

## Summary
[2-4 sentences highlighting key findings or stating no issues found]
**Severities Found**: [Critical, High, Medium, Low, or Clean]

## Findings

### [Issue Title]
**Issue Type**: [Label]
**Severity**: [Level]
**Location**: [file:line]
**Description**: [Details]
**Fix**: [Recommendation]
```

Choose appropriate formatting based on audit scope and user needs.

### 6. Output Report

**Dual output:**
- Display the report in the console/chat

Confirm with user:
- "Security audit complete. Found [N] issues ([breakdown by severity])"
- "Review the detailed findings above"

## Output Format

The skill produces:

**Formatting adapts to context:**
- **Full package audits**: Structured markdown with summary and detailed findings
- **Targeted reviews**: Concise list of issues found
- **Quick checks**: Brief feedback focused on specific concerns

**All reports include** (per the gist requirements):
- Each issue must have: Issue Type Label, Severity, Description, Location, Recommended Fix
- Use only standardized labels from the gist
- Clear indication if no security issues found

**If no significant issues found:**
Report states clearly that no security vulnerabilities were identified in the audited scope.

**If issues found:**
- Highest-severity issues highlighted first
- Each issue includes all required fields (label, severity, location, description, fix)
- Issues grouped or ordered by severity for clarity

## Examples

### Example 1: Full Package Audit

**Invocation**: "Run security audit on this R package"

**Process**:
1. Confirms audit scope: DESCRIPTION, NAMESPACE, R/, src/
2. Fetches audit instructions
3. Reads all package files
4. Analyzes for security issues
5. Generates report with findings

**Output**: Report identifying 3 issues: 1 High (command injection in system() call), 1 Medium (missing input validation), 1 Low (deprecated function usage)

### Example 2: Native Code Only Audit

**Invocation**: "Security audit only the src/ directory"

**Process**:
1. Confirms scope: src/ only
2. Fetches audit instructions
3. Reads C/C++ files in src/
4. Analyzes for memory safety and native code issues
5. Generates focused report

**Output**: Report identifying buffer overflow risk and unsafe sprintf usage

### Example 3: Clean Package

**Invocation**: "Check this package for security vulnerabilities"

**Process**:
1. Audits full package scope
2. Finds no significant security issues
3. Generates clean report

**Output**: Report with "Clean" severity indicating good security practices

## Notes

- **Audit instructions are versioned**: The gist reference ensures all audits use consistent criteria
- **Not a replacement for manual review**: This skill identifies common patterns but may miss context-specific issues
- **Native code analysis**: More complex than R code; focus on common unsafe patterns
- **Dependencies**: Check DESCRIPTION for known vulnerable packages, but detailed CVE lookup may require external tools
- **False positives possible**: Some flagged issues may be safe in context; use judgment
- **Regular audits recommended**: Run before major releases or when adding security-sensitive features

## Related Skills

- **analyze-r-package**: Understand package structure before auditing
- **validate-skill**: Validate this skill meets repository standards
- **create-package-instructions**: Generate broader package documentation

---

**Reference**: Security audit criteria defined at https://gist.github.com/lwaldron/0606c678e7d81b012a1b05901cf4b732
