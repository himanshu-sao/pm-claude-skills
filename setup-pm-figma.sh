#!/bin/bash

# =============================================================================
# setup-pm-figma.sh
# Run from the ROOT of your pm-claude-skills repo.
# Creates all 10 Figma skills in both skills/ and plugins/pm-figma/skills/
# =============================================================================

set -e
REPO_ROOT="$(pwd)"

if [ ! -d "$REPO_ROOT/plugins" ] || [ ! -d "$REPO_ROOT/skills" ]; then
  echo "ERROR: Run from the root of pm-claude-skills"
  exit 1
fi

write_skill() {
  local BUNDLE="$1"
  local SKILL="$2"
  local CONTENT="$3"
  mkdir -p "$REPO_ROOT/skills/$SKILL"
  mkdir -p "$REPO_ROOT/plugins/$BUNDLE/skills/$SKILL"
  printf '%s' "$CONTENT" > "$REPO_ROOT/skills/$SKILL/SKILL.md"
  printf '%s' "$CONTENT" > "$REPO_ROOT/plugins/$BUNDLE/skills/$SKILL/SKILL.md"
  echo "  ✓ $SKILL"
}

echo "================================================"
echo " Creating pm-figma skills (10 skills)..."
echo "================================================"
echo ""

# -------------------------------------------------------
# SKILL 1: figma-component-audit
# -------------------------------------------------------
write_skill "pm-figma" "figma-component-audit" '---
name: figma-component-audit
description: "Audit a Figma component library for consistency, coverage gaps, and naming issues. Use when asked to audit components, review a design system, check component consistency, identify missing components, or assess Figma library health. Produces a structured audit report with issues prioritised by impact, naming recommendations, and a fix plan."
---

# Figma Component Audit Skill

Produces a structured audit of a Figma component library — identifying inconsistencies, naming problems, coverage gaps, and prioritised recommendations.

## Required Inputs

- **Component list or description** (paste component names or describe what exists)
- **Product type** (mobile app / web app / desktop / multi-platform)
- **Design system maturity** (new / growing / mature / legacy)
- **Primary concern** (optional)

## Output Structure

### 1. Audit Summary

| Dimension | Status | Score |
|---|---|---|
| Naming consistency | Red/Amber/Green | /10 |
| Component coverage | | /10 |
| Variant completeness | | /10 |
| Documentation | | /10 |
| Overall health | | /10 |

**Verdict:** What is the state of this library and the single most important thing to fix?

### 2. Naming Issues

For each problem:
**Issue: [Problem type]**
- What is happening: [Specific examples]
- Why it matters: [Impact on designers and developers]
- Fix: [Exact naming convention to adopt]
- Examples: Before / After

Naming convention to enforce:
- Components: PascalCase (NavigationBar)
- Variants: Lowercase with slashes (size/large, state/hover)
- Pages: All caps (COMPONENTS, FOUNDATIONS)

### 3. Coverage Gaps

| Missing Component | Priority | Why Needed |
|---|---|---|
| [Component] | High/Medium/Low | [Use case] |

### 4. Variant Completeness Check

| Component | Default | Hover | Active | Disabled | Error | Missing |
|---|---|---|---|---|---|---|
| [Button] | Yes | Yes | No | Yes | No | Active, Error |

### 5. Prioritised Fix Plan

| # | Fix | Effort | Impact | Do First? |
|---|---|---|---|---|
| 1 | [Fix] | Low/Med/High | High | Yes |

## Quality Checks
- [ ] Naming recommendations have before/after examples
- [ ] Coverage gaps are relevant to the product type
- [ ] Fix plan is ordered by impact-to-effort ratio
- [ ] Variant completeness covers all interactive states

## Example Trigger Phrases
- "Audit my Figma component library"
- "Review our design system for consistency issues"
- "What components are we missing in our Figma library?"
- "Our component naming is a mess — help me fix it"
- "Do a health check on our Figma components"'

# -------------------------------------------------------
# SKILL 2: figma-design-brief
# -------------------------------------------------------
write_skill "pm-figma" "figma-design-brief" '---
name: figma-design-brief
description: "Write a structured design brief for a Figma design task from a product requirement or feature request. Use when asked to write a design brief, create a design spec for Figma, turn a PRD into design requirements, or brief a designer on what to build in Figma. Produces a brief with goals, scope, user flows, components needed, constraints, and success criteria."
---

# Figma Design Brief Skill

Converts a product requirement or feature request into a structured design brief — everything a designer needs to open Figma and start building confidently.

## Required Inputs

- **Feature or requirement** (paste PRD snippet, ticket, or describe the feature)
- **User goal** (what is the user trying to accomplish?)
- **Platform** (iOS / Android / Web / Responsive / All)
- **Existing components available** (optional)
- **Timeline** (when does design need to be ready?)

## Output Structure

### 1. Brief Header
Feature, PM, Designer, Platform, Design due, Dev handoff dates.

### 2. What We Are Designing and Why
- **The goal:** [One sentence — user problem being solved]
- **Context:** [2-3 sentences. Why now? What triggers this?]
- **Success looks like:** [Specific observable outcome]

### 3. User Flows to Design

**Flow N: [Flow name]**
- Entry point: [Where user starts]
- Steps: [Numbered key steps]
- Exit point: [Where flow ends]
- Edge cases: [empty state, error state, loading state]

### 4. Screens Required

| Screen | New / Update | Notes |
|---|---|---|
| [Screen] | New | [Key requirement] |

### 5. Components Needed

| Component | In library? | Action |
|---|---|---|
| [Component] | Yes/No/Needs variant | Use/Create/Extend |

### 6. Constraints and Requirements
- Must haves: [Non-negotiable constraints]
- Must avoid: [Design patterns to not use]
- Accessibility: [WCAG level, touch target sizes]

### 7. Open Questions
- [ ] [Question — with owner]

## Quality Checks
- [ ] Goal is outcome-focused (not "design the feature")
- [ ] All flows include edge cases
- [ ] Components table identifies create vs reuse
- [ ] Constraints include accessibility requirements
- [ ] Open questions have owners

## Example Trigger Phrases
- "Write a design brief for [feature]"
- "Turn this PRD into a Figma design brief"
- "Brief the designer on what to build for [requirement]"
- "Create a design spec for [feature] for Figma"
- "What does the designer need to know to design [feature]?"'

# -------------------------------------------------------
# SKILL 3: figma-annotation-guide
# -------------------------------------------------------
write_skill "pm-figma" "figma-annotation-guide" '---
name: figma-annotation-guide
description: "Generate structured developer handoff annotations for a Figma screen or component. Use when asked to write Figma annotations, create dev handoff notes, document a Figma design for developers, or write specs for a screen. Produces a complete annotation set covering interactions, states, spacing, accessibility, and edge cases."
---

# Figma Annotation Guide Skill

Produces a complete set of developer handoff annotations for a Figma screen or component — the notes that turn a visual design into a buildable spec.

## Required Inputs

- **Screen or component description** (describe or summarise what was designed)
- **Platform** (iOS / Android / Web / React Native)
- **Interaction type** (static / interactive / animated / form)
- **Developer audience** (mobile / frontend / full-stack)

## Output Structure

### 1. Screen/Component Overview
Name, purpose, entry points, exit points.

### 2. Interaction Annotations

**[Element name]**
- Default state: [Visual description]
- On tap/click: [Exact action — API call, state change, navigation]
- Loading state: [Description]
- Success state: [What happens after]
- Error state: [What error looks like and user options]
- Disabled condition: [When and why]

### 3. State Inventory

| Element | States Required |
|---|---|
| [Element] | Default, Hover, Active, Disabled, Loading, Error, Empty |

Flag missing designs: "Warning: Error state not designed — needed before build"

### 4. Spacing and Layout Notes
Fixed vs fluid elements, scroll behaviour, breakpoints, safe areas.

### 5. Content and Copy Rules
Character limits, dynamic vs static content, truncation rules, empty states.

### 6. Accessibility Annotations
Touch targets, screen reader labels, focus order, colour contrast, motion preferences.

### 7. Edge Cases and Developer Questions
- [ ] [Unresolved question for developer to flag]

## Quality Checks
- [ ] Every interactive element has all states defined
- [ ] State inventory flags missing designs
- [ ] Accessibility covers touch targets and screen reader labels
- [ ] Empty states specified
- [ ] Edge cases listed as actionable questions

## Example Trigger Phrases
- "Write dev annotations for this Figma screen"
- "Create developer handoff notes for [screen/component]"
- "Document this design for the engineering team"
- "Write the Figma spec for [feature]"
- "What should I annotate before handing off this design?"'

# -------------------------------------------------------
# SKILL 4: figma-design-review
# -------------------------------------------------------
write_skill "pm-figma" "figma-design-review" '---
name: figma-design-review
description: "Run a structured PM design review against product requirements. Use when asked to review a Figma design, check a design against requirements, do a PM design review, or assess whether a design meets the product spec. Produces a requirements coverage check, UX concerns, open questions, and explicit approval status."
---

# Figma Design Review Skill

Runs a structured PM design review — checking that a design meets product requirements, covers all user flows, and is ready for engineering. This is a requirements-and-outcomes review, not an aesthetic critique.

## Required Inputs

- **Design description or screen summary**
- **Original requirements** (PRD snippet, ticket, or acceptance criteria)
- **User flow being designed**
- **Review stage** (concept / mid-fidelity / pre-handoff final)

## Output Structure

### 1. Review Header
Feature, review stage, reviewed by, date.
**Overall status:** Approved / Approved with changes / Needs revision

### 2. Requirements Coverage Check

| Requirement | Covered? | Notes |
|---|---|---|
| [Requirement from PRD] | Yes/No/Partial | [Specific observation] |

Missing coverage summary: [Requirements not addressed — must resolve before approval]

### 3. User Flow Completeness

| Flow step | Designed? | Issues |
|---|---|---|
| [Step] | Yes/No/Partial | [Issue] |
| Error state | Yes/No | |
| Empty state | Yes/No | |
| Loading state | Yes/No | |

### 4. PM Concerns

**[Concern] — Blocking / Should fix / Nice to fix**
- What: [Specific observation]
- Why it matters: [Business or user impact — not aesthetic preference]
- Suggested resolution: [What PM wants to see]

### 5. Open Questions

| Question | Owner | Needed by |
|---|---|---|
| [Question] | Designer/Eng/PM | [Date] |

### 6. Approval Decision
Approved / Approved with changes (list) / Needs revision (focus area + next review date)

## Quality Checks
- [ ] Every requirement assessed
- [ ] All flow states checked (error, empty, loading)
- [ ] Concerns are outcome-focused not aesthetic
- [ ] Open questions have owners
- [ ] Approval status is explicit

## Example Trigger Phrases
- "Review this Figma design against the requirements"
- "Do a PM design review for [feature]"
- "Check if this design meets the product spec"
- "Is this design ready to hand off to engineering?"
- "What is missing from this design before we can build it?"'

# -------------------------------------------------------
# SKILL 5: figma-user-flow-planner
# -------------------------------------------------------
write_skill "pm-figma" "figma-user-flow-planner" '---
name: figma-user-flow-planner
description: "Plan user flows and screen states for a Figma design before any designing starts. Use when asked to plan a user flow, map out screens for a feature, define screen states, plan a Figma file structure, or work out what needs to be designed before opening Figma. Produces a complete flow map with all screens, states, entry/exit points, and a suggested Figma page structure."
---

# Figma User Flow Planner Skill

Plans what needs to be designed before a pixel is touched — mapping all screens, states, entry points, and edge cases so designers do not discover missing states mid-build.

## Required Inputs

- **Feature or task being designed**
- **User type** (who performs this flow?)
- **Platform** (iOS / Android / Web / Multi-platform)
- **Starting point** (where does the user begin?)
- **Known edge cases** (optional)

## Output Structure

### 1. Flow Overview
Feature, user, goal, entry points, success exit, failure exits.

### 2. Screen Map

| # | Screen name | Type | Triggered by | Notes |
|---|---|---|---|---|
| 1 | [Screen] | New/Modal/Drawer/Toast | [What triggers] | [Considerations] |

Screen types to cover: entry, happy path, loading, success, error (network/validation/permission), empty, first-time/onboarding, edge cases.

### 3. State Matrix

**[Screen name]**

| State | Trigger | Visual change | Action available |
|---|---|---|---|
| Default | Page load | [Description] | [What user can do] |
| Loading | User taps action | Skeleton/spinner | None |
| Error | API failure | Error message | Retry/Go back |
| Empty | No data | Empty state | [CTA] |

### 4. Decision Points

**Decision: [Name]**
- If yes: [Screen N]
- If no: [Screen X]

### 5. Suggested Figma File Structure

```
Feature name/
- Cover
- Flow Map
- Happy Path
- Error States
- Empty States
- Edge Cases
- Handoff
```

### 6. What Not to Design Yet
[Explicit out-of-scope items — prevents scope creep]

## Quality Checks
- [ ] All three state types covered: loading, error, empty
- [ ] All decision points mapped with both branches
- [ ] Entry points include all realistic user paths
- [ ] Out-of-scope section is explicit
- [ ] Figma file structure matches screen map

## Example Trigger Phrases
- "Plan the user flow for [feature] in Figma"
- "What screens do I need to design for [feature]?"
- "Map out the states for [feature] before we start designing"
- "Help me structure my Figma file for [feature]"
- "What do we need to design before handing this to the developer?"'

# -------------------------------------------------------
# SKILL 6: figma-variant-matrix
# -------------------------------------------------------
write_skill "pm-figma" "figma-variant-matrix" '---
name: figma-variant-matrix
description: "Define component variants and states systematically for Figma. Use when asked to plan component variants, define states for a component, set up a Figma variant matrix, or work out what properties a component needs before building it. Produces a complete variant matrix with all properties, values, and combinations needed."
---

# Figma Variant Matrix Skill

Defines all variants, properties, and states a component needs before building it in Figma — preventing missing variants discovered after the component is already used across 40 screens.

## Required Inputs

- **Component name** (Button, Card, Input, Badge, Navigation item, etc.)
- **Component purpose** (what does it do, where is it used?)
- **Platform** (iOS / Android / Web / Multi-platform)
- **Design system context** (standalone / part of existing system)

## Output Structure

### 1. Component Overview
Name, category (Interactive/Display/Layout/Form/Navigation/Feedback), used in contexts.

### 2. Variant Properties

| Property | Values | Notes |
|---|---|---|
| Type | Primary, Secondary, Tertiary, Destructive | |
| Size | Large, Medium, Small | |
| State | Default, Hover, Active, Disabled, Loading | |
| Icon | None, Leading, Trailing, Only | |

Total combinations: [N]. Flag if over 50 — consider splitting into multiple components.

### 3. State Definitions

For each state, list only what changes from Default:
- Default: [Full visual spec]
- Hover (web): [Delta from default]
- Active/Pressed: [Delta]
- Disabled: [Delta — use layer-level properties, not opacity on whole component]
- Loading: [What replaces label, interactive during loading?]
- Error (forms): [Border colour, helper text, icon changes]

### 4. Anatomy Breakdown

| Layer name | Purpose | Required? | Notes |
|---|---|---|---|
| container | Background and bounds | Yes | |
| label | Text | Conditional | Hide when icon-only |
| icon-leading | Leading icon slot | No | |

### 5. Token Mapping

| Property | Token | Fallback |
|---|---|---|
| Background default | color.brand.primary | #hex |
| Border radius | radius.medium | 8px |

### 6. Build Order
1. Default state, most common variant
2. Convert to component, add properties
3. Size variants
4. State variants
5. Type variants
6. Icon slot variants last

## Quality Checks
- [ ] All interactive states defined
- [ ] Total variant count calculated, flagged if over 50
- [ ] Every layer named semantically
- [ ] Token mapping covers all visual properties
- [ ] Disabled state uses layer-level properties not opacity

## Example Trigger Phrases
- "Define the variants for a [component] in Figma"
- "What states does my [component] need?"
- "Help me plan the variant matrix for [component]"
- "Set up the Figma properties for a [button/card/input]"
- "What are all the combinations I need for my [component]?"'

# -------------------------------------------------------
# SKILL 7: figma-spacing-system
# -------------------------------------------------------
write_skill "pm-figma" "figma-spacing-system" '---
name: figma-spacing-system
description: "Design a spacing and layout token system for a Figma design system. Use when asked to create a spacing system, define layout tokens, set up a grid system, build a spacing scale, or establish layout foundations for a Figma file. Produces a complete spacing scale, grid definition, component spacing conventions, and Figma implementation guide."
---

# Figma Spacing System Skill

Produces a complete spacing and layout token system — the foundation that makes a design system consistent and developer handoff unambiguous.

## Required Inputs

- **Platform** (iOS / Android / Web / Multi-platform)
- **Base unit** (4px / 8px — default to 8px)
- **Design system name** (for token naming)
- **Component density** (compact / standard / comfortable)
- **Grid requirements** (or "derive from platform standard")

## Output Structure

### 1. Base Unit
[4px or 8px] with rationale. All values must be multiples.

### 2. Spacing Scale

| Token | Value | Use case |
|---|---|---|
| spacing.none | 0px | Removing space intentionally |
| spacing.xs | 4/8px | Icon padding, tight labels |
| spacing.sm | 8/12px | Internal component padding compact |
| spacing.md | 12/16px | Internal component padding standard |
| spacing.lg | 16/24px | Section padding, card internal |
| spacing.xl | 24/32px | Between components |
| spacing.2xl | 32/48px | Section separation |
| spacing.3xl | 48/64px | Page-level breaks |
| spacing.4xl | 64/96px | Hero sections |

### 3. Layout Grid

Mobile (375px): 4 columns, margin [value], gutter [value]
Tablet (768px): 8 columns, margin [value], gutter [value]
Desktop (1440px): 12 columns, margin [value], gutter [value], max content width [value]

### 4. Component Spacing Conventions

| Context | Token | Example |
|---|---|---|
| Button horizontal padding | spacing.md | Left/right |
| Button vertical padding | spacing.sm | Top/bottom |
| Card internal padding | spacing.lg | All sides |
| Input padding | spacing.sm vertical, spacing.md horizontal | |
| Icon gap from label | spacing.xs | |
| Section gap | spacing.xl | |

### 5. Figma Implementation
1. Create SPACING page documenting each token visually
2. Resources > Variables > create Number collection named Spacing
3. Apply variables to Auto Layout padding/gap values
4. Share token names with engineers as-is or via Tokens Studio

### 6. Anti-Patterns to Avoid
- Values not on the scale (13px, 22px) — round to nearest token
- Absolute pixel values in components instead of tokens
- Mixing 4px and 8px base units in the same product

## Quality Checks
- [ ] All token values are multiples of the base unit
- [ ] Scale covers xs through 4xl
- [ ] Grid defined for all relevant breakpoints
- [ ] Component conventions cover common decisions
- [ ] Figma implementation steps included

## Example Trigger Phrases
- "Create a spacing system for our Figma design system"
- "Define our spacing tokens for Figma"
- "Set up a grid and spacing scale for [product]"
- "What spacing values should we use in our design system?"
- "Help me build the layout foundation for our Figma file"'

# -------------------------------------------------------
# SKILL 8: figma-prototype-plan
# -------------------------------------------------------
write_skill "pm-figma" "figma-prototype-plan" '---
name: figma-prototype-plan
description: "Plan prototype interactions and flows for user testing in Figma. Use when asked to plan a Figma prototype, set up prototype interactions, define what to prototype for a user test, or prepare a Figma prototype for usability testing. Produces a prototype scope, interaction specification, test task scripts, and Figma setup guide."
---

# Figma Prototype Plan Skill

Plans what to prototype in Figma and how — scoping to what the user test needs, defining every interaction, and setting up the test scenarios. Prevents over-building and ensures the prototype answers the research question.

## Required Inputs

- **Research question** (what are you trying to learn?)
- **Feature or flow being prototyped**
- **Prototype fidelity** (low wireframe / mid functional / high pixel-perfect)
- **Testing method** (moderated in-person / moderated remote / unmoderated)
- **Number of test tasks**

## Output Structure

### 1. Prototype Scope

**In scope:** [Flows with real interactions — specific screens listed]
**Out of scope:** [Screens to show as static — not worth building as interactive]
**Rationale:** Prototypes should be the minimum needed to test the hypothesis.

### 2. Interaction Specification

**Interaction N: [Description]**
- Trigger: Tap/Swipe/Hover/Form submit
- Element: [Figma layer name]
- Destination: [Figma frame name]
- Animation: Instant/Dissolve/Push left/Push right/Slide up
- Timing: [ms]
- Reset after: Yes/No

### 3. Prototype Flow Diagram

```
[Start frame]
  -> Tap "Action"
[Next frame]
  -> Tap "Complete" -> [Success frame]
  -> Tap "Cancel"   -> [Back to start]
```

### 4. Test Task Scripts

**Task N: [Title]**

Scenario (read to participant):
"[Realistic scenario giving context without directing the click path]"

Observing:
- [What to watch for]

Success when: [Specific trigger]

### 5. Figma Setup Guide
- Starting frame: [Name]
- Device preview: [Device]
- Prototype settings: background colour, show device, type
- Sharing: Can view link, reset process between participants

### 6. Build vs Fake Table

| Element | Build | Fake | Notes |
|---|---|---|---|
| Primary CTA flow | Yes | | Core to research |
| Secondary nav | | Yes | Not being tested |
| Error state | Yes | | Testing recovery |

## Quality Checks
- [ ] Scope limited to what the research question requires
- [ ] Every interaction has a named destination frame
- [ ] Task scripts are scenario-based (not "click on X")
- [ ] Success criteria defined for each task
- [ ] Reset process defined for between participants

## Example Trigger Phrases
- "Plan the Figma prototype for our user test on [feature]"
- "What interactions do I need to build for this prototype?"
- "Help me set up a Figma prototype for [research question]"
- "Write the test task scripts for our [feature] prototype"
- "What should I prototype vs leave as static screens?"'

# -------------------------------------------------------
# SKILL 9: figma-design-qa
# -------------------------------------------------------
write_skill "pm-figma" "figma-design-qa" '---
name: figma-design-qa
description: "Run a pre-handoff QA checklist on any Figma design before it goes to engineering. Use when asked to QA a Figma design, do a pre-handoff check, review a design before engineering, or validate a Figma file is ready to build. Produces a structured QA checklist covering file hygiene, component usage, accessibility, and handoff readiness with pass/fail status."
---

# Figma Design QA Skill

Runs a systematic pre-handoff QA check on a Figma design — catching issues that cause engineering back-and-forth before they become expensive.

## Required Inputs

- **Feature or screen being QA-d**
- **Platform** (iOS / Android / Web)
- **Design system** (custom / Material / HIG / None)
- **Handoff tool** (Figma Inspect / Zeplin / Storybook / Direct link)
- **QA depth** (quick 15 min / standard 30 min / thorough 60 min)

## Output Structure

QA Report: [Feature] | [Date] | [Platform]
**Overall status:** Ready / Minor fixes needed / Not ready

### Section 1: File Hygiene
- All layers named semantically (no "Rectangle 12")
- No unused/hidden layers in final frames
- Components from library (not detached copies)
- All text uses text styles (not manual font settings)
- All colours use styles or variables (not hex overrides)
- Frames named to match screen map
- No leftover prototype wires to wrong frames

### Section 2: Component Usage
- All buttons use library component
- All inputs use library component
- All icons from approved icon library
- No custom components that should be in library
- Variants used correctly (right size, state, type)

### Section 3: Content and Copy
- No placeholder text (Lorem ipsum) in final designs
- All copy reviewed and approved
- Realistic content used (not "User Name")
- Long text edge cases tested
- Error messages are human-readable
- Empty states have copy and CTA

### Section 4: States and Coverage
- Default, Loading, Empty, Error, Success states
- Interactive elements have hover/active (web)
- Disabled states designed where applicable

### Section 5: Accessibility
- All text meets WCAG AA contrast (4.5:1 body, 3:1 large)
- UI components meet 3:1 contrast against background
- Touch targets minimum 44x44pt iOS / 48x48dp Android
- Focus states for keyboard/switch navigation (web)
- Information not conveyed by colour alone
- Icons have text labels or accessible names annotated

### Section 6: Handoff Readiness
- Dev annotations on non-obvious interactions
- Spacing uses Auto Layout (not absolute positioning)
- Images/assets exported at correct resolutions
- Design matches approved requirements
- Link to prototype included

### Issues Found
For each fail:
**[Issue] — Blocking / Fix before handoff / Fix in next iteration**
- What: [Specific layer/screen/element]
- Fix: [Exact action needed]
- Owner: [Designer/PM/Both]

### Handoff Decision
Status, signed off by, date.

## Quality Checks
- [ ] All 6 sections completed
- [ ] Every fail has a specific description and fix action
- [ ] Blocking issues separated from minor ones
- [ ] Handoff decision is explicit

## Example Trigger Phrases
- "QA this Figma design before handoff"
- "Run a pre-handoff check on [feature] design"
- "Is this Figma design ready for engineering?"
- "Do a design QA on [screen/feature]"
- "What needs fixing before we hand this off?"'

# -------------------------------------------------------
# SKILL 10: figma-design-critique-pm
# -------------------------------------------------------
write_skill "pm-figma" "figma-design-critique-pm" '---
name: figma-design-critique-pm
description: "Run a PM-perspective design critique focused on product outcomes, user goals, and business requirements — not aesthetics. Use when asked for a PM design critique, a product review of a design, feedback on a Figma design from a product perspective, or when you want to critique a design without being a designer. Produces structured outcome-based feedback tied to user goals and business metrics."
---

# Figma Design Critique — PM Perspective Skill

This skill is specifically for product managers critiquing designs — focused on whether the design achieves the user goal and business outcome, not whether it looks good. Different from the general design-critique skill which covers UX aesthetics; this one centres product thinking.

## Required Inputs

- **Design description or screen summary**
- **User goal** (what is the user trying to accomplish?)
- **Business goal** (what outcome does the product need?)
- **Original requirements** (what was this supposed to do?)
- **Key metric** (what would move if this design works?)

## Output Structure

### 1. PM Critique Summary
User goal, business goal restated.
**Verdict:** On track / Mostly on track / Needs rethinking

One-paragraph summary: what works from a product perspective, and the single most important thing to address.

### 2. Goal Alignment Check

| Goal | Design supports it? | Evidence |
|---|---|---|
| [User goal] | Yes/Partial/No | [Specific observation] |
| [Business goal] | Yes/Partial/No | [Observation] |
| [Key requirement] | Yes/Partial/No | [Observation] |

### 3. PM Feedback (Outcome-Focused)

Every concern must tie to an outcome. "I do not like this layout" is not PM feedback. "This layout puts the primary action below the fold, which will reduce mobile conversion" is PM feedback.

**[Concern] — High/Medium/Low impact**
- Observation: [Neutral description of what the design does]
- User impact: [What this means for the user goal]
- Business impact: [What this means for the metric]
- Evidence basis: [Research/data/analogous patterns/hypothesis — be honest]
- Question for designer: [What to explore — not a directive]

### 4. What the Design Does Well
2-4 specific things working well from a product perspective — with evidence. Not "colours are nice" but "primary CTA is the most prominent element, aligning with conversion goal." Always include this section.

### 5. Questions Before Next Iteration

| Question | Who answers | Why it matters |
|---|---|---|
| [Question] | Designer/PM/Eng | [Impact] |

### 6. PM Recommendation
Approve / Approve with changes (list) / Revise and re-review (one focus area only)

## PM Critique Rules
- Never reference aesthetics as reason for feedback — only outcomes
- "I prefer" is not feedback — "users are likely to" is feedback
- Lead with what is working before what is not
- Ask questions before giving directives
- One primary recommendation — not a redesign in bullets

## Quality Checks
- [ ] Every concern tied to user or business outcome
- [ ] What is working section is genuine and specific
- [ ] Questions section included (not just directives)
- [ ] PM recommendation is explicit
- [ ] Evidence basis stated honestly

## Example Trigger Phrases
- "Give me a PM critique of this design"
- "Review this design from a product perspective"
- "What product feedback do I have on this Figma design?"
- "Critique this design without being a designer"
- "Does this design achieve the user goal?"'

echo ""
echo "================================================"
echo " All 10 pm-figma skills created successfully!"
echo ""
echo " Skills written to:"
echo "   skills/figma-component-audit/"
echo "   skills/figma-design-brief/"
echo "   skills/figma-annotation-guide/"
echo "   skills/figma-design-review/"
echo "   skills/figma-user-flow-planner/"
echo "   skills/figma-variant-matrix/"
echo "   skills/figma-spacing-system/"
echo "   skills/figma-prototype-plan/"
echo "   skills/figma-design-qa/"
echo "   skills/figma-design-critique-pm/"
echo ""
echo " And mirrored into:"
echo "   plugins/pm-figma/skills/[each skill]/"
echo ""
echo " Next: run create-plugin-json-pm-figma.sh"
echo "================================================"
