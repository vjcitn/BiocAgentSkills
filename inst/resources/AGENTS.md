# Agent Behavior Standard

## Purpose

This document defines the canonical behavior rules that ALL AI agents must follow to work with waldronlab's skill repository. It establishes a platform-agnostic contract: agents adapt to this standard, not the other way around.

## Core Principles

### 1. Agent Neutrality

Skills are platform-agnostic by design. They contain no embedded vendor-specific metadata or logic. Agents are responsible for:
- Discovering skills via the canonical SKILLS.md index
- Matching user natural language to skill descriptions
- Adapting their platform-specific mechanics (slash commands, @workspace triggers, etc.) to invoke skills

Skills do not reference `platforms:`, `triggers:`, or other agent-specific configuration.

### 2. Single Source of Truth

- **One repository**: waldronlab/ai-agent-skills is the authoritative source
- **One skill file per skill**: Located at `skills/{skill-name}/SKILL.md`
- **One description per skill**: Agents use this description to understand when to invoke the skill
- **No duplication**: Do not maintain separate versions for Claude, Copilot, or other agents

### 3. Natural Language Invocation

Skills are discovered and invoked through natural language matching, not rigid command syntax:

- **Discovery**: Agents read SKILLS.md to find available skills
- **Matching**: Agent matches user's natural language intent to skill descriptions
- **Invocation**: Agent invokes the skill using its own platform mechanics
- **Flexibility**: Platform-specific shortcuts (slash commands, @workspace) are optional conveniences, documented separately

Example:
- User says: "I want to create a new skill"
- Agent reads SKILLS.md and finds: "create-skill: Help create a new AI agent skill through collaborative Q&A"
- Agent recognizes the match and invokes the skill
- Claude Code might use `/create-skill` shortcut; Copilot might route via `@workspace` pattern

### 4. Skill Execution Model

**Agents read and follow skills as instructions:**

1. Read the skill file (SKILL.md)
2. Understand the skill's purpose from the description
3. Follow the documented process step-by-step
4. Adapt tool usage to agent's available capabilities
5. Produce output as documented in the skill

Skills are **prompts**, not code. Agents interpret and execute them using their own tools.

### 5. Portability Over Convenience

- Prioritize long-term interoperability over short-term optimization
- Design for future agents, not just current platforms
- Avoid locking skills to specific agent APIs or syntax
- Make skills work on minimal assumptions (just markdown + YAML frontmatter)

### 6. Workflow over Code Snippets

Skills must define workflows (the *intent*, *multi-step process*, and *domain knowledge*), not just provide raw code. While highly specific code snippets can be provided to overcome LLM anti-patterns, handle unique APIs, or adhere to strict lab standards (e.g., `BiocParallel` vs `lapply`), they must serve strictly as **guardrails** embedded within a numbered workflow step, never as the entire skill itself.

## Skill File Format

### Minimal Required Fields

Every skill MUST include these YAML frontmatter fields:

```yaml
---
name: skill-name              # Unique identifier (kebab-case, REQUIRED)
description: Brief purpose    # One-line description driving discovery (REQUIRED)
version: 1.0.0               # Semantic version (REQUIRED)
category: meta               # Primary domain: meta, r-packages, etc. (REQUIRED)
author: waldronlab           # Creator/maintainer (OPTIONAL)
tags: [tag1, tag2]          # Searchable tags (OPTIONAL)
---
```

### What NOT to Include

Skills **MUST NOT** contain:
- ❌ `platforms:` field (skills are agent-agnostic by design)
- ❌ `triggers:` field (agents use natural language + SKILLS.md for discovery)
- ❌ Agent-specific tool references (e.g., "use the Read tool")
- ❌ Platform-specific invocation syntax (e.g., "/command" or "@workspace" patterns)

### Content Structure (Recommended)

```markdown
# [Skill Name]

Brief overview (1-2 paragraphs).

## Usage

How users naturally invoke this skill.
Agents will adapt this to their platform.

## Prerequisites

Required files, setup, or dependencies.

## Process

Numbered steps describing what to do.
Platform-agnostic language: "read the file", not "use Read tool".

## Output Format

Expected output structure or examples.

## Platform-Specific Notes (Optional)

Only if meaningful platform differences exist.
Document HOW platforms differ, not what they should do.

## Examples

Concrete usage scenarios.

## Notes

Additional context or caveats.
```

**Principle**: Describe WHAT to do, not HOW (specific tools). Let agents figure out HOW with their available capabilities.

## Avoiding Content Duplication

Skills must maintain this document (AGENTS.md) as the single source of truth for format specifications and standards.

### What NOT to Duplicate in Skills

Skills MUST NOT duplicate:
- ❌ YAML field specifications from § Skill File Format
- ❌ Required/prohibited field lists from § Minimal Required Fields / § What NOT to Include
- ❌ Platform-agnostic principles from § Agent Neutrality
- ❌ Content structure requirements from § Content Structure
- ❌ External standards or checklists (reference the source instead)

### How to Reference Properly

Instead of duplicating, use references:
```markdown
✅ "See AGENTS.md § Skill File Format for complete specification"
✅ "Check that frontmatter conforms to AGENTS.md § Minimal Required Fields"
✅ "Use the standardized labels defined in [external source URL]"

❌ Do not list: "Required fields: name, description, version, category..."
❌ Do not copy: YAML templates or field descriptions
❌ Do not duplicate: External classification systems or checklists
```

### When to Include Content

Skills SHOULD include:
- ✅ Skill-specific logic and workflow steps
- ✅ Domain-specific knowledge and context
- ✅ Concrete examples relevant to the skill's purpose
- ✅ Decision trees or branching logic unique to the skill

**Principle**: Reference authoritative sources; only include content unique to the skill's purpose.

## Skill Discovery & Invocation

### Primary Discovery Mechanism: SKILLS.md

The file `SKILLS.md` is the canonical skill index. It is:
- **Human-readable**: Browse and search by category, tag, use case
- **Agent-parseable**: Agents extract skill locations and descriptions
- **Maintained in parallel with skills**: Updated when skills are added/changed
- **Source of truth for discovery**: Authoritative list of available skills

Format:
```markdown
### [Category]

#### [Skill Name]
**Purpose**: From skill description
**Location**: `skills/[name]/SKILL.md`
**Invocation**: "Natural language the user might say"
**When to use**: Context for when this skill applies
```

### Invocation Pattern

1. **User provides intent** (natural language): "Create a new skill for validating R packages"
2. **Agent reads SKILLS.md**: Finds matching skill based on description
3. **Agent invokes skill**: Using platform-specific mechanism
   - Claude Code: `/create-skill` (optional shortcut)
   - Copilot: `@workspace create a new skill` (optional shortcut)
   - Other agents: Custom mechanism, but same underlying skill
4. **Agent executes skill**: Follows documented process, adapts tools as needed
5. **User receives output**: Consistent regardless of platform

### Optional Platform-Specific Shortcuts

Agents MAY provide platform-specific shortcuts for convenience:
- Claude Code: `/skill-name` slash commands
- GitHub Copilot: `@workspace` pattern triggers
- Others: Platform-appropriate equivalents

**Important**: These shortcuts are **optional conveniences**, not the primary invocation mechanism. Users who don't know or use these shortcuts can still invoke skills through natural language.

## Agent Responsibilities

### MUST (Mandatory)

Compliant agents:
- [ ] MUST support SKILLS.md as the primary discovery mechanism
- [ ] MUST support natural language skill invocation matching descriptions
- [ ] MUST read and follow SKILL.md process documentation
- [ ] MUST adapt tool usage to agent's available capabilities
- [ ] MUST produce output as documented in the skill
- [ ] MUST NOT embed platform-specific requirements in skills
- [ ] MUST ask the user if the work should be done on a new branch before editing files
- [ ] MUST NOT commit changes without explicit approval from the user
- [ ] MUST show a draft commit message for the user's approval in a standard text response prior to committing
- [ ] MUST acknowledge the AI agent being used so that it will appear as a co-author (e.g., appending the GitHub co-author trailer `Co-authored-by: AI Agent <agent@example.com>` at the end of the commit message, separated by a blank line).

### SHOULD (Strong Recommendation)

- [ ] SHOULD document platform shortcuts in instructions/{agent}.md (setup and usage only, not skill descriptions)
- [ ] SHOULD test all skills before promoting to production
- [ ] SHOULD handle errors gracefully and guide users to skill documentation
- [ ] SHOULD direct users to [SKILLS.md](SKILLS.md) as the authoritative skill catalog

### MAY (Optional)

- [ ] MAY provide optional platform-specific shortcuts for convenience (e.g., `/skill-name`, `@workspace` patterns)
- [ ] MAY provide additional UX conveniences (auto-completion, suggestion UI, etc.)
- [ ] MAY extend skills with platform-specific enhancements
- [ ] MAY implement caching or optimization for performance

## Platform Adapter Requirements

### What Adapters Are

Platform adapters are **thin wrapper documents** that explain:
- How to install skills for a specific agent
- Platform-specific invocation shortcuts (optional)
- Troubleshooting tips for that platform
- How that platform differs from the canonical behavior

Located in: `instructions/{agent-name}.md`

### What Adapters Must NOT Do

- ❌ Duplicate skill logic
- ❌ Define new invocation patterns (reference SKILLS.md instead)
- ❌ Require platform-specific fields in skills
- ❌ Create vendor lock-in

### What Adapters Should Include

- ✅ Setup/installation instructions specific to the platform
- ✅ References to AGENTS.md and SKILLS.md as authoritative sources
- ✅ Optional platform-specific shortcuts (if any) with explanations
- ✅ Troubleshooting tips for that platform
- ✅ Brief explanation of how that platform differs from canonical behavior (if applicable)

**What Adapters Must NOT Include**:
- ❌ Skill invocation examples (those belong in SKILLS.md only)
- ❌ Skill descriptions or purpose statements (reference SKILLS.md instead)
- ❌ Step-by-step skill process details (these live in SKILL.md files)

Example minimal structure:

```markdown
# Claude Code Setup

## Installation

[Setup steps for configuring skills on Claude Code]

## Using Skills

1. Browse available skills in [SKILLS.md](../SKILLS.md)
2. Invoke naturally: "Analyze this R package"
3. Optional: Use slash commands if configured (e.g., `/analyze-r-package`)

## Troubleshooting

[Platform-specific troubleshooting tips]

See [AGENTS.md](../AGENTS.md) for canonical behavior and [SKILLS.md](../SKILLS.md) for skill catalog.
```

## Responsibility Mapping: Single Source of Truth

This section clarifies **what goes where** to maintain clean separation of concerns and avoid duplication.

### Skill Invocation Examples

**Who owns it**: SKILLS.md only

**What goes in SKILLS.md**:
```markdown
**Invocation**:
- "Help me create a new skill"
- "Create a skill for [domain]"
- "I want to make a skill that..."
```

**What does NOT go in instructions/{agent}.md**:
- ❌ Lists of invocation examples
- ❌ "When to use this skill" descriptions
- ❌ Alternative ways to say the same thing

**Why**: Duplicating invocation examples across platform adapters creates maintenance burden. SKILLS.md is the single source.

### Platform-Specific Shortcuts

**Who owns it**: instructions/{agent}.md only

**What goes in instructions/{agent}.md**:
```markdown
Optional shortcuts for this platform:
- `/create-skill` - Shortcut for "create a new skill"
- `/analyze-r-package` - Shortcut for "analyze this R package"
```

**What goes in skill files**: Nothing. Shortcuts are platform-specific conveniences, not core skill metadata.

**Why**: Shortcuts vary by platform (Claude Code uses `/`, Copilot uses `@workspace`, etc.). They're configuration, not skill logic.

### Skill Process & Logic

**Who owns it**: SKILL.md files only

**What goes in SKILL.md**:
- Step-by-step process
- Prerequisites
- Output format
- Examples
- Platform-agnostic logic

**What does NOT go in instructions/{agent}.md**:
- ❌ How to run the skill
- ❌ What the skill produces
- ❌ Step-by-step skill process

**Why**: Skill logic is platform-agnostic. All agents follow the same process.

### Setup & Configuration

**Who owns it**: instructions/{agent}.md only

**What goes in instructions/{agent}.md**:
- How to install skills for this platform
- Configuration files (settings.json, CLAUDE.md, etc.)
- Platform-specific troubleshooting
- References to authoritative sources (AGENTS.md, SKILLS.md)

**Example**: "Add to ~/.claude/CLAUDE.md: [reference]/SKILLS.md"

### Canonical Behavior Rules

**Who owns it**: AGENTS.md (this file)

**What goes in AGENTS.md**:
- How agents discover skills (via SKILLS.md)
- How agents invoke skills (natural language matching)
- Mandatory agent responsibilities
- Prohibited skill metadata (platforms, triggers)
- Compliance criteria

### Technical Format Specification

**Who owns it**: SKILL_STANDARD.md

**What goes in SKILL_STANDARD.md**:
- YAML frontmatter fields
- Markdown structure
- Validation checklist
- Examples of well-formed skills

---

## Compliance Criteria

An agent is **compliant** with this standard if it:

1. **Reads SKILLS.md** as the primary skill index
2. **Matches natural language** user requests to skill descriptions
3. **Invokes skills** by reading and following SKILL.md documentation
4. **Adapts tool usage** to the agent's available capabilities
5. **Produces output** as documented in each skill
6. **Does not require** platform-specific metadata in skills
7. **Documents deviations** (if any) in instructions/{agent}.md

## Scope & Limitations

### This Standard Covers

- How agents discover skills
- How agents invoke skills
- What metadata skills should/must not contain
- How platform differences are documented
- Compliance criteria for agents

### This Standard Does Not Cover

- Technical implementation details (see SKILL_STANDARD.md)
- Individual skill logic (see SKILLS.md for navigation)
- How agents manage state, context, or persistence
- Agent-specific optimizations or UX enhancements

## Relationship to Other Documents

- **SKILL_STANDARD.md**: Technical format specification for skill files (WHAT structure to use)
- **AGENTS.md** (this file): Canonical behavior rules for agents (WHAT agents must do)
- **SKILLS.md**: Human-readable index of available skills (WHERE to find skills, WHEN to use them)
- **instructions/{agent}.md**: Platform-specific setup and optional shortcuts (HOW to use on this platform)

## Questions & Clarifications

### Q: Can we have platform-specific triggers in YAML?

**A**: No. Triggers are platform-specific by nature. Use natural language matching via SKILLS.md instead. Platform shortcuts are optional conveniences documented in instructions/{agent}.md, not core skill metadata.

### Q: What if a skill needs different logic for different agents?

**A**: Document the platform differences in a "Platform-Specific Notes" section within the skill. Let each agent adapt the approach to their capabilities.

### Q: How do agents discover new skills?

**A**: They read SKILLS.md. When you add a skill, update SKILLS.md with location, purpose, and example invocations.

### Q: Can agents cache SKILLS.md or skill files?

**A**: Yes. But they must re-validate against the repository version periodically to stay current.

### Q: What about MCP (Model Context Protocol) servers?

**A**: MCP is optional infrastructure. Skills are designed to work as plain markdown + YAML, with or without MCP support. If an agent uses MCP, it's an implementation detail, not a requirement here.

## Version History

- **2.0.0** (2026-04-03) - Agent behavior standard
  - Established core principles: agent neutrality, single source of truth, natural language discovery
  - Defined mandatory and optional agent responsibilities
  - Specified prohibited skill metadata (platforms, triggers)
  - Established SKILLS.md as primary discovery mechanism
  - Clarified responsibility mapping and single source of truth principles

## Maintenance

**Maintained by**: waldronlab

**When to update**:
- New compliance criteria identified
- Major structural changes to skill repository
- New agent types added with novel requirements

**Change process**:
1. Open issue describing needed change
2. Discuss rationale with maintainers
3. Submit PR with updated AGENTS.md
4. Increment version
5. Tag release and notify affected agents

---

**The key principle**: Agents adapt to this standard and repository, not the other way around. Skills are portable, platform-agnostic prompts. Agents are the layer that brings them to life on specific platforms.
