---
name: check-waldronlab-skills
description: Verify that waldronlab/ai-agent-skills are available and help users find the right skill
version: 1.0.0
category: meta
tags: [meta, infrastructure, discovery]
author: waldronlab
---

# check-waldronlab-skills

Help any user confirm that waldronlab skills are installed and visible, then provide a concise catalog of available skills with short descriptions.

This skill is intended as a quick health check and discovery entry point for the `waldronlab/ai-agent-skills` repository.

## Usage

Invoke this skill to check your setup or discover available skills:
- "Do I have the waldronlab skills?"
- "What waldronlab skills are there?"
- "Is there a good waldronlab skill for [task]?"
- "List available waldronlab skills"

## Prerequisites

- The `waldronlab/ai-agent-skills` repository is present locally
- Skill files are accessible through your configured skill locations or project-level instruction links

## Process

1. **Read SKILLS.md** from repository root
2. **Parse by category** extracting skill names, descriptions, and categories
3. **For listing**: Present organized by category with brief descriptions
4. **For recommendations**: Match user need to skill descriptions, recommend 1-2 best-fit
5. **Report status**: "🏃 Levi says let's go!" (found) or "❌ Not detected" (not found)

## Output Format

- **Skill listing**: Organize by category with brief descriptions (dynamically from SKILLS.md)
- **Recommendations**: Primary + optional companion with rationale
- **Not found**: Suggest checking configuration or filing issue

## Examples

### Example 1: Installation Check

**User**: "Do I have the waldronlab skills?"

**Response** (dynamically from SKILLS.md):
```
🏃 Levi says let's go!

Available waldronlab skills:

Meta
  • [skills from Meta Skills section]

R/Bioconductor
  • [skills from R/Bioconductor section]

[Additional categories from SKILLS.md]

See SKILLS.md for details.
```

### Example 2: Skill Recommendation

**User**: "Is there a good waldronlab skill for creating package instructions?"

**Response**:
```
Yes! I recommend:

**Primary**: [skill-name from SKILLS.md]
[Rationale]

**Companion**: [related skill] (optional)
[How it complements]
```

## Troubleshooting

**Skills not detected**:
- Verify skill paths in editor settings
- Ensure waldronlab/ai-agent-skills repository is cloned
- Reload window
- See `instructions/claude.md` or `instructions/copilot.md` for setup

**Duplicate listings**: Multiple configuration locations pointing to same skills (normal)

## Notes

- **Dynamic discovery**: This skill reads SKILLS.md at runtime to discover available skills, ensuring it never goes out of sync
- **Single source of truth**: SKILLS.md is the authoritative skill catalog; this skill queries it rather than duplicating content
- Keep responses concise and actionable
- Prioritize helping users confirm setup quickly
- If skills are missing, provide actionable next steps
- This skill complements SKILLS.md as the quick-check discovery tool

See [AGENTS.md](../../AGENTS.md) for how skill discovery works and [SKILLS.md](../../SKILLS.md) for the complete index.

---

**Related**: SKILLS.md (complete skill index), instructions/claude.md, instructions/copilot.md
