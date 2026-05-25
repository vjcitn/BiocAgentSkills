# Contributing

Thank you for your interest in contributing to waldronlab AI Agent Skills!

## What You Can Contribute

### New Skills

Have a workflow or pattern that would help others?

**Quick start**: Use the `create-skill` skill for guided help:
- "Help me create a new skill for [purpose]"

**Manual process**:
1. Create directory: `skills/{skill-name}/`
2. Create file: `skills/{skill-name}/SKILL.md`
3. Follow [SKILL_STANDARD.md](SKILL_STANDARD.md) format
4. **Validate**: Use `validate-skill` to check compliance
5. Fix any issues found in validation report
6. Test on at least 3 different projects
7. Submit PR

### Improve Existing Skills

Found a bug or enhancement?
1. Test your changes on multiple projects
2. Update [SKILLS.md](SKILLS.md) if description changes
3. Document breaking changes clearly
4. Submit PR

### Examples

Add examples showing skill output:
1. Use `skills/{skill-name}/examples/` directory
2. Include representative real-world case
3. Document what makes it notable
4. Submit PR

### Documentation

Fix typos, clarify instructions, update outdated info - all welcome via PR.

### Issues

Report bugs or suggest features via [GitHub Issues](https://github.com/waldronlab/ai-agent-skills/issues).

## How to Contribute

### Small Changes (typos, doc fixes)

1. Fork the repository
2. Make your changes
3. Submit pull request

### New Skills or Major Changes

1. **Open an issue first** to discuss your proposal
2. Get feedback from maintainers
3. Fork and create feature branch
4. Develop following [SKILL_STANDARD.md](SKILL_STANDARD.md)
5. **Validate**: Run `validate-skill` to ensure standards compliance
6. Fix any CRITICAL or WARNING issues from validation
7. Test thoroughly (at least 3 projects)
8. Update [SKILLS.md](SKILLS.md) to include your skill
9. Submit pull request

## Skill Guidelines

### Required

- Follow [SKILL_STANDARD.md](SKILL_STANDARD.md) format
- Include required YAML frontmatter: `name`, `description`, `version`, `category`
- No `platforms:` or `triggers:` fields (skills are agent-agnostic)
- Use natural language invocation examples
- Test on multiple projects before submitting

### Format Example

```yaml
---
name: my-skill
description: One-line purpose for discovery
version: 1.0.0
category: domain
tags: [tag1, tag2]
author: your-name
---

# my-skill

What this skill does.

## Usage

Natural language examples:
- "Do [task] for me"
- "Help me with [thing]"

## Process

### 1. First Step

Platform-agnostic description of what to do.

### 2. Second Step

Continue with clear steps.

## Examples

Show realistic usage scenarios.
```

### Testing & Validation

Before submitting:
- **Run validation**: Use `validate-skill` to check standards compliance
- Fix all CRITICAL issues and strongly consider fixing WARNING issues
- Test on at least 3 different projects
- Verify output accuracy
- Check edge cases
- Get feedback from others if possible

## Pull Request Process

1. Create clear PR description explaining what and why
2. Reference any related issues
3. Ensure all tests pass (if applicable)
4. Respond to review feedback
5. Be patient - reviews typically take 2-7 days

## Questions?

- **Skill creation help**: Use the `create-skill` skill
- **Validation help**: Use the `validate-skill` skill to check if your skill meets standards
- **Setup questions**: See [instructions/](instructions/) for your platform
- **General questions**: [GitHub Discussions](https://github.com/waldronlab/ai-agent-skills/discussions)
- **Bugs/features**: [GitHub Issues](https://github.com/waldronlab/ai-agent-skills/issues)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

For technical details on skill format, see [SKILL_STANDARD.md](SKILL_STANDARD.md).

For understanding how skills work, see [AGENTS.md](AGENTS.md) and [SKILLS.md](SKILLS.md).
