# Examples: pm-figma Skills

## What this bundle does
10 Figma skills covering the full design lifecycle for product managers and designers — from planning what to design, through building components and prototypes, to QA before handoff.

---

## figma-component-audit

### Example 1 — Messy legacy library

**You say:**
> "Audit our Figma component library. We have buttons, inputs, cards, modals, and navigation components but the naming is all over the place and developers keep asking for states we haven't designed."

**Claude produces:**

**Audit Summary**

| Dimension | Status | Score |
|---|---|---|
| Naming consistency | 🔴 Poor | 3/10 |
| Component coverage | 🟡 Partial | 6/10 |
| Variant completeness | 🔴 Poor | 4/10 |
| Overall health | 🟡 Partial | 5/10 |

**Issue: Mixed capitalisation conventions**
- What's happening: `button-primary`, `Button/Primary`, `btn_primary` all exist in the same library
- Fix: Adopt PascalCase for components (`Button`), lowercase slash-separated for variants (`type/primary`, `size/large`, `state/default`)
- Before: `btn_primary_large_hover` → After: `Button` with variants `type/primary`, `size/large`, `state/hover`

**Missing states developers are asking for:**
| Component | Missing | Priority |
|---|---|---|
| Button | Active/pressed state | 🔴 High |
| Input | Error state with helper text | 🔴 High |
| Card | Skeleton loading state | 🟡 Medium |

---

## figma-design-brief

### Example 1 — PRD to design brief

**You say:**
> "Write a design brief for our new notification preferences feature. Users need to control which emails and push notifications they receive. Platform is iOS and Android. We need design ready in 2 weeks."

**Claude produces:**

**Feature:** Notification Preferences
**Platform:** iOS + Android | **Design due:** [2 weeks from today] | **Dev handoff:** [3 weeks]

**The goal:** Users can control their notification preferences without contacting support.

**Success looks like:** >80% of users who visit settings can update their preferences without a support ticket.

**Flows to design:**
1. Entry from Settings > Notifications
2. Toggle individual notification types on/off
3. Save preferences with confirmation
4. Error state if save fails

**Missing from current brief — open questions:**
- [ ] Are email and push controlled separately or together? (PM to confirm)
- [ ] What's the default state for new users? (PM to confirm)

---

## figma-design-qa

### Example 1 — Pre-handoff check

**You say:**
> "QA the checkout flow design before we hand it off to engineering. Web, using our custom design system, standard 30-minute QA."

**Claude produces:**

**Design QA Report: Checkout Flow**
**Overall status:** 🟡 Minor fixes needed

**Section 1: File Hygiene**
- All layers named semantically ✅
- No unused layers ✅
- Components from library ❌ — Order summary card is a detached copy
- Text uses text styles ✅
- Colours use variables ❌ — Button label in step 3 uses hardcoded #FFFFFF instead of `color.text.on-primary`

**Issues Found:**
- **Detached card component — 🟡 Fix before handoff**
  - What: Order summary card (frame "Step 2 / Summary") is not linked to library
  - Fix: Re-attach to `Card/Summary` library component
  - Owner: Designer

---

## figma-design-critique-pm

### Example 1 — PM reviewing a dashboard design

**You say:**
> "Give me a PM critique of our new analytics dashboard design. User goal is to understand their campaign performance at a glance. Business goal is to reduce support tickets about 'why are my numbers down'."

**Claude produces:**

**PM Critique Summary**
Verdict: 🟡 Mostly on track with one significant gap

"The design successfully surfaces the top-line metrics above the fold and the date range selector is prominent. However, the design currently shows no contextual explanation for metric changes — a user whose conversions dropped 40% last week will still need to contact support because there's nothing in the design helping them understand why."

**Goal Alignment Check:**
| Goal | Status | Evidence |
|---|---|---|
| Understand performance at a glance | ✅ Yes | Top 4 KPIs are above fold, well-contrasted |
| Reduce "why are my numbers down" tickets | 🟡 Partial | Metrics shown but no context or anomaly explanation |

**PM Feedback:**
**Missing: Metric change context — 🔴 High impact**
- Observation: Metric cards show current value and % change vs prior period but no explanation of what drove the change
- User impact: A user seeing -40% conversions still has no information to act on without contacting support
- Business impact: Does not address the core support ticket driver — the "why"
- Evidence basis: Hypothesis (we should validate with support ticket analysis)
- Question for designer: Is there data available to surface top contributing factors? Even "top declining campaign" would help.

---

## Tips for best results

- For `figma-design-brief`: paste the actual PRD snippet or ticket — the more specific the requirement, the more useful the brief
- For `figma-design-qa`: describe the platform and design system explicitly — the checklist adapts to iOS vs Android vs Web
- For `figma-design-critique-pm`: always state the business metric — without it, feedback stays generic
- For `figma-variant-matrix`: name the component exactly as it will appear in Figma — Claude uses this for layer naming recommendations
- For `figma-user-flow-planner`: state the starting point and user type — these determine which edge cases are most likely

## Related skills
- `design-critique` — General UX critique using Gestalt and Nielsen heuristics (pm-design bundle)
- `ux-research-plan` — Full research plan for user testing (pm-design bundle)
- `figma-prototype-plan` — Plan what to prototype before building it (this bundle)
