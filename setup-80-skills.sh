#!/bin/bash

# =============================================================================
# setup-80-skills.sh
# Run from the ROOT of your pm-claude-skills repo.
#
# This script does everything in one go:
# 1. Creates all required folders in skills/ and plugins/
# 2. Creates .claude-plugin/plugin.json for each of the 7 new bundles
# 3. Writes all 27 SKILL.md files into both skills/ and plugins/
#
# Usage:
#   cd ~/pm-claude-skills
#   chmod +x setup-80-skills.sh
#   bash setup-80-skills.sh
# =============================================================================

set -e

REPO_ROOT="$(pwd)"

echo "================================================"
echo " pm-claude-skills — 80 Skills Setup"
echo " Running from: $REPO_ROOT"
echo "================================================"
echo ""

# Sanity check
if [ ! -d "$REPO_ROOT/plugins" ] || [ ! -d "$REPO_ROOT/skills" ]; then
  echo "ERROR: Cannot find plugins/ or skills/ directory."
  echo "Make sure you are running from the ROOT of pm-claude-skills."
  exit 1
fi

# Helper function — writes a SKILL.md to both locations
write_skill() {
  local BUNDLE="$1"      # e.g. pm-legal
  local SKILL="$2"       # e.g. contract-review
  local CONTENT="$3"     # the full file content

  mkdir -p "$REPO_ROOT/skills/$SKILL"
  mkdir -p "$REPO_ROOT/plugins/$BUNDLE/skills/$SKILL"

  echo "$CONTENT" > "$REPO_ROOT/skills/$SKILL/SKILL.md"
  echo "$CONTENT" > "$REPO_ROOT/plugins/$BUNDLE/skills/$SKILL/SKILL.md"
  echo "  ✓ $SKILL"
}

# =============================================================================
# BUNDLE: pm-legal
# =============================================================================
echo "Creating pm-legal bundle..."
mkdir -p plugins/pm-legal/.claude-plugin

cat > plugins/pm-legal/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-legal",
  "version": "1.0.0",
  "description": "Legal skills: Contract Review, NDA Analyser, Legal Brief, Compliance Checklist. Flag risks in contracts and NDAs, draft legal memos in IRAC format, and generate GDPR, SOC 2, FCA and other compliance checklists. Not a substitute for qualified legal advice.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["legal", "contract-review", "nda", "compliance", "gdpr", "legal-brief", "risk"]
}
EOF

write_skill "pm-legal" "contract-review" '---
name: contract-review
description: "Review and summarise any contract or legal agreement. Use when asked to review a contract, check an agreement, flag legal risks, or summarise key clauses. Produces a structured review with key terms, flagged clauses, risk rating, and plain English summary. Not a substitute for qualified legal advice."
---

# Contract Review Skill

This skill produces a structured contract review identifying key terms, unusual or high-risk clauses, and a plain English summary. Always include the disclaimer that this is not legal advice.

## Required Inputs
- **Contract text or description** (paste or describe)
- **Reviewer role** (e.g. the party signing, their legal team, a business owner)
- **Contract type** (e.g. SaaS agreement, employment contract, NDA, supplier contract)
- **Key concerns** (optional — e.g. "focus on IP ownership and termination clauses")

## Output Structure

### 1. Contract Overview
- **Type:** [Contract type]
- **Parties:** [Party A and Party B]
- **Effective date / duration:** [If stated]
- **Governing law:** [Jurisdiction]
- **Overall risk rating:** Green Low / Amber Medium / Red High

### 2. Key Terms Summary

| Term | Detail |
|---|---|
| Payment / fees | |
| Term and renewal | |
| Termination rights | |
| Liability cap | |
| IP ownership | |
| Confidentiality | |
| Dispute resolution | |

### 3. Flagged Clauses

For each flagged clause:

**[Risk level] — [Clause name]**
- **What it says:** [Plain English summary]
- **Why it matters:** [Risk or implication]
- **Suggested action:** [Negotiate / Accept / Seek legal advice / Query]

### 4. Missing Clauses
List any standard clauses absent but normally expected for this contract type.

### 5. Plain English Summary
3-5 sentences. What does this contract mean for the party signing it?

### 6. Recommended Next Steps
- [Action 1]
- [Action 2]

---

WARNING: This review is for informational purposes only and does not constitute legal advice. Always consult a qualified solicitor or lawyer before signing any legally binding agreement.

## Example Trigger Phrases
- "Review this contract: [paste]"
- "Flag the key risks in this agreement"
- "Summarise this SaaS contract in plain English"
- "What should I watch out for in this supplier agreement?"'

write_skill "pm-legal" "nda-analyser" '---
name: nda-analyser
description: "Analyse a Non-Disclosure Agreement (NDA) and flag key terms, unusual provisions, and negotiation points. Use when asked to review an NDA, mutual NDA, confidentiality agreement, or non-disclosure deed. Produces clause-by-clause analysis with risk flags and a negotiation checklist."
---

# NDA Analyser Skill

NDAs are often treated as routine paperwork but contain terms with significant long-term consequences. This skill analyses them systematically.

## Required Inputs
- **NDA text** (paste in full or describe key clauses)
- **Your party position** (disclosing / receiving / mutual)
- **Purpose of the NDA** (e.g. pre-sales, hiring, M&A, partnership)
- **Industry context** (optional)

## Output Structure

### 1. NDA Type and Parties
- **Type:** Unilateral / Mutual
- **Disclosing party:** [Name]
- **Receiving party:** [Name]
- **Purpose:** [As stated]
- **Governing law:** [Jurisdiction]
- **Term:** [Duration of obligations]

### 2. Definition of Confidential Information
- **How broadly defined?** Narrow / Standard / Very broad
- **Oral disclosures included?** Yes / No / With conditions
- **Standard exclusions present?** [public domain, prior knowledge, independently developed, legally required disclosure]
- **Flag:** [Unusual inclusions or missing exclusions]

### 3. Key Clause Analysis

**[Clause name] — Concern / Watch / Standard**
- **What it says:** [Plain English]
- **Issue:** [Why flagged]
- **Standard position:** [What this typically looks like]
- **Negotiation suggestion:** [If applicable]

Clauses always covered: permitted use, non-solicitation/non-compete, term and post-termination obligations, return/destruction of information, remedies, liability, residuals clause.

### 4. Negotiation Checklist

| Point | Current position | Suggested ask |
|---|---|---|
| [e.g. Confidentiality term] | [e.g. 5 years] | [e.g. Reduce to 2 years] |

### 5. Plain English Verdict
2-3 sentences. Standard NDA, one-sided, or needs a lawyer?

---

WARNING: This analysis is for informational purposes only and is not legal advice. Consult a qualified solicitor before signing.

## Example Trigger Phrases
- "Analyse this NDA"
- "Review this confidentiality agreement"
- "Is this NDA standard or unusual?"
- "What should I negotiate in this mutual NDA?"'

write_skill "pm-legal" "legal-brief" '---
name: legal-brief
description: "Draft a structured legal brief, case summary, or legal argument outline. Use when asked to write a legal brief, case note, legal memo, argument outline, or position paper. Produces a structured document using IRAC format (Issue, Rule, Application, Conclusion)."
---

# Legal Brief Skill

This skill drafts structured legal briefs and memos using IRAC format — the standard structure for legal writing.

## Required Inputs
- **Brief type** (legal memo / case summary / argument outline / position paper / letter before action)
- **Legal issue or question**
- **Jurisdiction** (England & Wales / US / EU / Other)
- **Relevant facts**
- **Relevant law or cases** (if known — otherwise flagged as [RESEARCH NEEDED])
- **Audience** (internal memo / court submission / client letter)

## Output Structure

### Header
- **To:** [Recipient]
- **From:** [Author]
- **Date:** [Date]
- **Re:** [Matter reference]
- **Confidential:** Subject to legal professional privilege

### Issue(s)
One sentence per legal question:
- Issue 1: Whether X constitutes Y under [law]

### Brief Answer
One sentence per issue — conclusion upfront before analysis.

### Facts
Concise relevant facts only. Flag disputed facts.

### Law (Rule)
- Relevant statute, regulation, or case law
- How the rule has been interpreted in key cases
- Flag [RESEARCH NEEDED] where law is not provided

### Application
- Arguments in favour
- Counter-arguments and responses
- Areas of uncertainty flagged explicitly

### Conclusion
- Clear answer to each issue
- Overall recommendation
- Suggested next steps

### Caveats
What this memo does not cover. What additional research would change the analysis.

---

WARNING: This draft requires review by a qualified legal professional. It does not constitute legal advice.

## Example Trigger Phrases
- "Draft a legal memo on [issue]"
- "Write a legal brief arguing [position]"
- "Summarise the legal position on [topic]"
- "Write a letter before action for [situation]"'

write_skill "pm-legal" "compliance-checklist" '---
name: compliance-checklist
description: "Generate a compliance checklist for any regulation, standard, or policy. Use when asked to create a compliance checklist, regulatory review, audit checklist, or policy adherence review. Covers GDPR, ISO 27001, FCA, HIPAA, SOC 2, and other frameworks. Produces a prioritised checklist with pass/fail assessment and remediation actions."
---

# Compliance Checklist Skill

Generates a structured compliance checklist for any regulatory framework with a prioritised gap analysis and remediation actions.

## Required Inputs
- **Framework or regulation** (e.g. GDPR, HIPAA, SOC 2, ISO 27001, FCA Consumer Duty, PCI DSS)
- **Organisation type** (e.g. SaaS company, financial services, NHS trust, law firm)
- **Scope** (e.g. data handling, customer onboarding, IT security, HR processes)
- **Known gaps or concerns** (optional)

## Output Structure

### 1. Framework Overview
- **Regulation/Standard:** [Name and version]
- **Enforcement body:** [Regulator]
- **Overall compliance status:** Red Gaps / Amber Partial / Green Compliant

### 2. Compliance Checklist

| # | Requirement | Status | Priority | Action Required |
|---|---|---|---|---|
| 1 | [Plain English requirement] | Met / Gap / Partial / Unknown | Critical / High / Low | [Specific action] |

Priority definitions:
- Critical: Regulatory breach risk. Remediate immediately.
- High: Significant gap. Address within 30 days.
- Low: Best practice. Address in next review cycle.

### 3. Critical Gaps Summary
List only Critical items with: what is missing, regulatory requirement breached, recommended remediation and owner.

### 4. Recommended Remediation Plan

| Action | Owner | Timeline | Effort |
|---|---|---|---|
| [Specific action] | [Team/role] | [Timeframe] | Low/Med/High |

### 5. Documentation Gaps
Policies, records, or evidence needed to demonstrate compliance.

---

WARNING: This checklist is a starting point based on publicly available guidance. It does not constitute legal or compliance advice.

## Example Trigger Phrases
- "Create a GDPR compliance checklist for our SaaS product"
- "Generate a SOC 2 audit checklist"
- "Review our compliance against FCA Consumer Duty"
- "Build an ISO 27001 gap analysis"'

echo ""

# =============================================================================
# BUNDLE: pm-finance
# =============================================================================
echo "Creating pm-finance bundle..."
mkdir -p plugins/pm-finance/.claude-plugin

cat > plugins/pm-finance/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-finance",
  "version": "1.0.0",
  "description": "Finance skills: Financial Model Narrative, Budget Variance Analysis, Investor Pitch Deck, Financial Due Diligence. Turn numbers into board-ready narratives, explain variances, structure pitch decks, and generate DD checklists.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["finance", "financial-model", "budget", "variance", "pitch-deck", "due-diligence", "investor"]
}
EOF

write_skill "pm-finance" "financial-model-narrative" '---
name: financial-model-narrative
description: "Turn financial model outputs into a clear written narrative. Use when asked to write a financial narrative, explain a financial model, summarise a P&L, or translate spreadsheet numbers into a board-ready story. Produces an executive narrative with key insights, drivers, and forward-looking commentary."
---

# Financial Model Narrative Skill

Turns financial model outputs into a clear, structured written narrative suitable for board packs, investor updates, or management reporting.

## Required Inputs
- **Financial data** (paste key figures: revenue, costs, margins, EBITDA, cash)
- **Period covered** (month / quarter / annual / multi-year)
- **Audience** (board / investors / management / bank / internal)
- **Key message** (what is the headline story?)
- **Actuals vs budget / prior period?** (comparison context)

## Output Structure

### 1. Headline Summary
3-5 sentences. The financial story in plain English. Lead with the most important insight — not "revenue was X" but what that figure means.

### 2. Revenue
- Performance vs prior period / budget
- Key drivers: what caused the movement
- Risks or opportunities in the revenue line

### 3. Costs and Margins
- Gross margin: % and trend
- Key cost movements and why
- EBITDA performance and drivers
- One-off items clearly flagged

### 4. Cash and Balance Sheet
- Cash position and movement
- Runway (for startups)
- Key working capital movements

### 5. Variance Analysis
For each significant variance:

**[Line item] — Over/Under by [amount]**
- **Cause:** [Plain English explanation]
- **Permanent or temporary?** One-time / Structural
- **Action being taken:** [If applicable]

### 6. Forward-Looking Commentary
- Expected next period
- Key risks to forecast
- Key opportunities
- Any reforecast or guidance change

## Writing Rules
- Never just restate a number — always explain what it means
- Flag variances over 10% automatically
- Use past tense for actuals, conditional for forecast
- One insight per paragraph

## Example Trigger Phrases
- "Write a financial narrative for these results: [paste numbers]"
- "Turn this P&L into a board narrative"
- "Write the finance section of our board pack"
- "Explain these financial results in plain English"'

write_skill "pm-finance" "budget-variance-analysis" '---
name: budget-variance-analysis
description: "Produce a structured budget variance analysis from actual vs budget figures. Use when asked to analyse budget variances, explain underspend or overspend, write a variance commentary, or investigate why actuals differ from plan. Produces a categorised variance table with root cause analysis and management commentary."
---

# Budget Variance Analysis Skill

Produces a complete variance analysis from numbers through to root cause explanation and management commentary.

## Required Inputs
- **Actuals and budget figures** (paste as table or describe line by line)
- **Period** (month / quarter / YTD)
- **Materiality threshold** (e.g. £10k or 5%)
- **Known reasons for variances** (if any)
- **Audience** (CFO / board / management / auditor)

## Output Structure

### 1. Variance Summary Table

| Line Item | Budget | Actual | Variance £ | Variance % | F/A |
|---|---|---|---|---|---|
| Revenue | | | | | |
| Cost of Sales | | | | | |
| Gross Profit | | | | | |
| Opex | | | | | |
| EBITDA | | | | | |

F = Favourable | A = Adverse

### 2. Material Variance Commentary

For each variance above threshold:

**[Line item] — £[amount] F/A ([%])**
- **Root cause:** [Specific explanation — not "timing" without detail]
- **Permanent or timing?** Will this reverse next period?
- **Management action:** What is being done
- **Forecast impact:** Does this change full-year outlook?

### 3. Top 3 Variances Requiring Attention
Ranked by materiality and strategic significance.

### 4. Forecast Revision
Does the full-year forecast need updating? State revised expectation and key assumptions.

### 5. Executive Summary
3-4 sentences of management commentary suitable for a board pack.

## Quality Checks
- All variances above threshold explained
- Root causes specific (not vague)
- Favourable/Adverse correctly labelled
- Forecast impact stated for material variances

## Example Trigger Phrases
- "Write a variance analysis for these actuals vs budget: [paste]"
- "Explain why we are over budget on [cost line]"
- "Write the variance commentary for our finance review"
- "Produce a budget vs actual analysis for Q[N]"'

write_skill "pm-finance" "investor-pitch-deck" '---
name: investor-pitch-deck
description: "Build the narrative and slide structure for an investor pitch deck. Use when asked to create a pitch deck, investor presentation, fundraising deck, or startup pitch. Produces a slide-by-slide structure with narrative beats, key messages, and what each slide must prove to an investor."
---

# Investor Pitch Deck Skill

Builds the complete narrative and slide structure for an investor pitch deck — focused on what investors need to see, not what founders want to show.

## Required Inputs
- **Company name and one-line description**
- **Stage** (Pre-seed / Seed / Series A / Series B)
- **Ask** (how much raising and what for)
- **Key metrics** (revenue, growth, users, retention)
- **Target investors** (generalist / sector-specific / angels)
- **Deck length** (10 / 12 / 15 slides)

## Output Structure

For each slide:
- **What this slide must prove** (the investor question it answers)
- **Content guidance** (specific, not generic)
- **Common mistake to avoid**

---

**Slide 1: Cover** — Proves you can say what you do in one sentence.
**Slide 2: Problem** — Proves the problem is real, painful, and large. Lead with the human problem, not market size.
**Slide 3: Solution** — Proves your solution is meaningfully better. Focus on outcome, not features.
**Slide 4: Product** — Proves this is real and works. Show the actual product.
**Slide 5: Traction** — Proves people want this. Show retention and revenue, not signups.
**Slide 6: Market** — Proves the market is large enough. Use bottoms-up TAM where possible.
**Slide 7: Business Model** — Proves you understand unit economics. Include CAC and LTV.
**Slide 8: Go-To-Market** — Proves you can acquire customers efficiently. Focus on what is actually working.
**Slide 9: Competition** — Proves you understand the landscape. Never say "no competitors."
**Slide 10: Team** — Proves this team can execute this opportunity. One sentence per person, specific.
**Slide 11: Financials** — Proves you understand your business. Show assumptions, not just projections.
**Slide 12: The Ask** — Proves you know exactly what you need. Specific use of funds and 18-month milestones.

## Narrative Principles
- Every slide answers one investor question
- Investors decide go/no-go on slides 1-5 — front-load evidence
- Keep to 10-12 slides for a first meeting

## Example Trigger Phrases
- "Build a pitch deck structure for [company]"
- "Help me structure my Series A deck"
- "What slides should my investor pitch have?"'

write_skill "pm-finance" "financial-due-diligence" '---
name: financial-due-diligence
description: "Generate a financial due diligence checklist and analysis framework for any investment, acquisition, or partnership. Use when asked for a due diligence checklist, M&A financial review, investment analysis framework, or vendor financial assessment."
---

# Financial Due Diligence Skill

Produces a structured financial due diligence framework — document request list and analytical questions — for any investment, acquisition, or significant commercial relationship.

## Required Inputs
- **Transaction type** (acquisition / investment / partnership / supplier / fundraise)
- **Stage of diligence** (initial screening / full DD / confirmatory)
- **Target company type** (startup / SME / listed / subsidiary)
- **Key concerns** (optional — e.g. revenue recognition, customer concentration)

## Output Structure

### 1. Document Request List

**Financial Statements**
- Audited accounts for last 3 years
- Management accounts for current year (monthly)
- Board-approved budget and latest reforecast
- 3-year financial model with assumptions

**Revenue**
- Revenue by customer (top 20, % of total)
- Revenue by product/segment
- Contracted vs recurring vs one-off breakdown
- Churn and renewal data

**Costs**
- Cost of sales breakdown
- Headcount by department with compensation detail
- Top 10 supplier contracts

**Cash and Debt**
- Bank statements (12 months)
- Debt schedule with covenants and maturity
- Working capital analysis

**Tax**
- Last 3 years tax returns
- Any open enquiries
- R&D tax credit claims

### 2. Key Analytical Questions

**Revenue quality:** Is revenue growing organically? What % is truly recurring? Customer concentration risk?

**Margin analysis:** Gross margin trend over 3 years? One-off items inflating EBITDA? Normalised EBITDA?

**Cash conversion:** Does profit convert to cash? Cash conversion cycle? Working capital red flags?

**Debt and liabilities:** Net debt position? Contingent liabilities? Covenant headroom?

### 3. Red Flags Checklist
- Revenue concentration over 30% in one customer
- Declining gross margins without explanation
- EBITDA-to-cash conversion below 70%
- Auditor qualifications or emphasis of matter
- Related party transactions not at arm length
- Aggressive revenue recognition
- Growing debtor days with no explanation

### 4. Summary Output Template
- Revenue quality: [Assessment]
- Margin sustainability: [Assessment]
- Cash generation: [Assessment]
- Balance sheet risk: [Assessment]
- Overall: Green Strong / Amber Acceptable / Red Material concerns

## Example Trigger Phrases
- "Give me a financial due diligence checklist for [company type]"
- "What documents should I request for financial DD?"
- "Build a DD framework for our Series A investment"'

echo ""

# =============================================================================
# BUNDLE: pm-hr
# =============================================================================
echo "Creating pm-hr bundle..."
mkdir -p plugins/pm-hr/.claude-plugin

cat > plugins/pm-hr/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-hr",
  "version": "1.0.0",
  "description": "HR skills: Job Description Writer, Onboarding Plan, Employee Engagement Survey, Redundancy Consultation. Write inclusive JDs, build 30/60/90-day plans, design engagement surveys, and structure legally compliant redundancy processes.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["hr", "people", "job-description", "onboarding", "engagement", "redundancy", "recruitment"]
}
EOF

write_skill "pm-hr" "job-description-writer" '---
name: job-description-writer
description: "Write a clear, inclusive, and structured job description for any role. Use when asked to write a job description, job posting, JD, or job advert. Produces a complete JD with role summary, responsibilities, requirements, and inclusive language review."
---

# Job Description Writer Skill

Writes complete, inclusive job descriptions that attract the right candidates and reduce bias in the hiring process.

## Required Inputs
- **Job title and level**
- **Team and reporting line**
- **Top 5 things this person will actually do**
- **Must-have requirements** (be ruthless — only what is truly required)
- **Nice-to-have requirements**
- **Salary range** (JDs with salary ranges get 30% more applicants)
- **Location and remote policy**
- **Company description** (2-3 sentences)

## Output Structure

### [Job Title]
**[Company] | [Location] | [Remote policy] | [Salary range]**

**About [Company]**
[2-3 sentences. Specific and honest — not marketing copy.]

**The Role**
[3-4 sentences. What this person will own, why the role exists now, what success looks like in year one.]

**What You Will Do**
[6-8 bullet points. Outcomes and responsibilities, not activities. Start each with an action verb. Most important first.]

**What We Are Looking For**

Must have (4-6 items only):
- [Requirement]

Nice to have (3-4 items):
- [Nice to have]

**What We Offer**
[Compensation, benefits, development. Be specific.]

**How to Apply**
[Clear instructions. What to send, where, timeline.]

---

### Inclusive Language Review

**Words to remove or replace:**

| Original | Replace with | Why |
|---|---|---|
| "rockstar" | "experienced" | Gendered connotation |
| "ninja" | "skilled" | Same issue |
| "must have degree" | "relevant experience or qualification" | Excludes qualified non-graduates |

**Requirement audit:**
- Years of experience requirements flagged (screen out women and underrepresented groups disproportionately)
- Any requirements potentially discriminating against protected characteristics

## Quality Checks
- Salary range included
- Must-haves genuinely essential (6 items max)
- Each responsibility starts with action verb
- Inclusive language review completed
- No years-of-experience requirements unless legally required

## Example Trigger Phrases
- "Write a job description for a [role]"
- "Create an inclusive job posting for [role]"
- "Review and rewrite this JD: [paste]"'

write_skill "pm-hr" "onboarding-plan" '---
name: onboarding-plan
description: "Create a structured 30/60/90-day onboarding plan for any new hire. Use when asked to write an onboarding plan, new hire plan, 30-60-90 day plan, or first 90 days roadmap. Produces a week-by-week plan with milestones, meetings, learning goals, and success criteria."
---

# Onboarding Plan Skill

Creates a complete, structured onboarding plan tailored to a specific role — covering the first 90 days with clear milestones and success criteria.

## Required Inputs
- **Role and level** of the new hire
- **Team and manager**
- **Key stakeholders** they will work with
- **Top 3 priorities** for their first 90 days
- **Tools and systems** they will need access to
- **Company stage** (startup / scaleup / enterprise)

## Output Structure

### Onboarding Plan: [Name] — [Role]
**Start date:** [Date] | **Manager:** [Name] | **Buddy:** [Name]

---

### Before Day 1 (Manager checklist)
- IT setup: laptop, accounts, email, Slack, key tools
- Access provisioned to key systems
- First week calendar blocked with key meetings
- Buddy assigned and briefed
- Welcome message sent with Day 1 logistics

---

### Week 1: Orient
Theme: Listen, learn, do not act yet.

| Day | Focus | Key activities |
|---|---|---|
| Day 1 | IT setup, team intro | 1:1 with manager, team lunch |
| Day 2 | Product deep dive | Demo, key docs to read |
| Day 3 | Process and tools | Shadow key workflows |
| Day 4 | Stakeholder intros | 3-4 intro 1:1s |
| Day 5 | Week 1 debrief | Check-in, questions logged |

**Week 1 milestone:** Can describe what the company does, the team role, and their top 3 priorities.

---

### Days 8-30: Learn
Learning goals:
- Deep understanding of product from customer perspective
- Know key metrics the team is measured on
- Understand current projects and status
- Map key stakeholder relationships
- Complete all compliance/HR training

**30-day milestone:** All stakeholder 1:1s complete. 2-3 early observations shared with manager.

---

### Days 31-60: Contribute
Goals:
- Own at least one project end-to-end
- Make one meaningful contribution
- Build cross-functional relationships
- Identify one process improvement

**60-day milestone:** Delivered one tangible output. Manager says "this person is contributing."

---

### Days 61-90: Lead
Goals:
- Operating independently on core responsibilities
- Has formed and shared a point of view on priorities
- Building reputation with key stakeholders

**90-day milestone:** Ready for formal review. Clear 6-month plan in place.

---

### 90-Day Review Questions
Manager: Meeting expectations? What to double down on? What to develop?
New hire: Have the clarity, tools, support needed? What surprised you? What would you change about onboarding?

## Example Trigger Phrases
- "Create a 30/60/90 day plan for a new [role]"
- "Write an onboarding plan for [name] starting as [role]"
- "Build a first 90 days roadmap for our new hire"'

write_skill "pm-hr" "employee-engagement-survey" '---
name: employee-engagement-survey
description: "Design an employee engagement survey and analyse results. Use when asked to create an employee survey, engagement questionnaire, pulse survey, or eNPS survey. Also use when asked to analyse survey results. Produces a complete survey with questions, rating scales, and an analysis framework."
---

# Employee Engagement Survey Skill

Designs complete employee engagement surveys and provides a framework for analysing and acting on results.

## Mode Detection
- User provides survey results -> Analysis mode
- User wants to create a survey -> Design mode

---

## Design Mode

### Required Inputs
- Survey type (annual / quarterly pulse / post-onboarding / exit / specific topic)
- Company size and stage
- Key areas of concern (optional)
- Anonymity approach
- Length target (short: 5-10 / standard: 15-25 / comprehensive: 30+)

### Opening Statement (always include)
"This survey is anonymous. Your responses help us understand what is working and what to improve. Results will be shared with [who] and we will communicate actions taken by [date]."

### Core Questions

**Overall Engagement**
1. On a scale of 0-10, how likely are you to recommend [Company] as a great place to work? (eNPS)
2. I feel proud to work at [Company]. [1-5]
3. I intend to still be working here in 12 months. [1-5]

**Role and Clarity**
4. I understand how my work contributes to company goals. [1-5]
5. I have the tools and resources I need to do my job. [1-5]
6. My workload is manageable. [1-5]

**Manager and Team**
7. My manager gives useful feedback. [1-5]
8. My manager cares about my development. [1-5]
9. I feel part of a team that works well together. [1-5]

**Culture and Belonging**
10. I feel I can be myself at work. [1-5]
11. People treat each other with respect. [1-5]
12. [Company] lives by its stated values. [1-5]

**Growth and Recognition**
13. I have opportunities to grow and develop. [1-5]
14. My contributions are recognised. [1-5]
15. I have had a meaningful career conversation in the last 6 months. [Yes/No]

**Open questions (always include)**
- What is one thing [Company] should start doing?
- What is one thing [Company] should stop doing?
- Anything else to share?

---

## Analysis Mode

### Analysis Output

**1. Headline Scores**
| Metric | Score | Benchmark | Trend |
|---|---|---|---|
| eNPS | [-100 to +100] | Industry avg | vs last survey |

eNPS: Below 0 = Concerning / 0-30 = Good / 30-70 = Great / 70+ = Excellent

**2. Strengths** — Top scoring areas with evidence.

**3. Improvement Areas** — 3 lowest scoring areas with verbatim comment themes.

**4. Action Planning Template**
| Improvement area | Action | Owner | Timeline | Measure |
|---|---|---|---|---|

**5. Communication Template** — Draft message to share results with employees.

## Example Trigger Phrases
- "Create an employee engagement survey for our team"
- "Design a pulse survey for [topic]"
- "Analyse these engagement survey results: [paste]"'

write_skill "pm-hr" "redundancy-consultation" '---
name: redundancy-consultation
description: "Structure a redundancy consultation process and draft key communications. Use when asked to plan a redundancy process, write a redundancy letter, structure a consultation, or manage a reduction in force. UK employment law focus. Always recommend qualified HR/legal advice before proceeding."
---

# Redundancy Consultation Skill

Structures redundancy processes and drafts communications. Significant legal and human risk — always flag that employment legal advice is essential before proceeding.

WARNING: Defaults to UK employment law (Employment Rights Act 1996). Always recommend qualified HR/legal advice before any redundancy action.

## Required Inputs
- **Number of roles affected** (1-19 = individual; 20+ = collective consultation required)
- **Reason for redundancy** (genuine business reason)
- **Jurisdiction** (UK / US / EU / Other)
- **Timeline constraints**
- **Selection pool** (if multiple people in similar roles)

## Output Structure

### 1. Process Overview

**Individual redundancy (fewer than 20):**
| Stage | Action | Minimum timeline |
|---|---|---|
| 1 | Confirm business case internally | Before any communication |
| 2 | At-risk notification meeting | Day 1 |
| 3 | Individual consultation | Minimum 1 meaningful meeting |
| 4 | Redundancy confirmed or alternative found | After genuine consideration |
| 5 | Notice period begins | Per contract |
| 6 | Final day and payment | Per contract + statutory |

**Collective redundancy (20+ roles — UK):**
- Minimum 45 days consultation before first dismissal
- Must notify BEIS (HR1 form) before consultation begins
- Employee representatives must be elected if no union recognised
- Failure = unlimited protective award per employee

### 2. Selection Criteria (if pool exists)
Objective, non-discriminatory only: skills/qualifications, performance (documented evidence), attendance (exclude disability/pregnancy-related absences), length of service (tiebreaker only).

NEVER select on: age, disability, pregnancy/maternity, part-time status, trade union membership.

### 3. At-Risk Letter Draft
"Dear [Name], I am writing to inform you that your role of [Job Title] is at risk of redundancy. This is because [specific business reason]. We would like to meet on [date] to discuss the situation and explore alternatives. You have the right to be accompanied by a colleague or trade union representative. No decision has been made. Yours sincerely, [Manager]"

### 4. Consultation Meeting Script
Opening: "No decision has been made. This meeting is to explain the situation and listen to your views."
Key questions: Any ways to avoid this? Alternative roles of interest? Anything about selection to challenge?

### 5. Redundancy Confirmation Letter Draft
Issued only after genuine consultation. Must include: statutory pay calculated, notice period, payment for accrued holiday, right of appeal.

### 6. Statutory Redundancy Pay Guide (UK)
- Under 22: 0.5 week per year of service
- 22-40: 1 week per year of service
- 41+: 1.5 weeks per year of service
- Weekly pay capped (verify current rate)
- Maximum 20 years counts

---

WARNING: Take advice from an employment lawyer or qualified HR professional before beginning any redundancy process.

## Example Trigger Phrases
- "Help me structure a redundancy consultation"
- "Draft an at-risk letter for [role]"
- "What is the process for making someone redundant in the UK?"'

echo ""

# =============================================================================
# BUNDLE: pm-sales
# =============================================================================
echo "Creating pm-sales bundle..."
mkdir -p plugins/pm-sales/.claude-plugin

cat > plugins/pm-sales/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-sales",
  "version": "1.0.0",
  "description": "Sales skills: Sales Battlecard, Discovery Call Prep, Proposal Writer, Account Plan. Build competitive battlecards, prepare structured discovery calls, write winning proposals, and create strategic account plans.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["sales", "battlecard", "discovery", "proposal", "account-plan", "competitive", "crm"]
}
EOF

write_skill "pm-sales" "sales-battlecard" '---
name: sales-battlecard
description: "Create a competitive sales battlecard for any competitor. Use when asked to build a battlecard, competitive comparison, sales cheat sheet, or objection handling guide for a specific competitor. Produces a one-page battlecard with positioning, differentiators, objection responses, and landmines."
---

# Sales Battlecard Skill

Produces a practical one-page competitive battlecard that sales reps can use in calls — not a theoretical analysis.

## Required Inputs
- **Your product/company**
- **Competitor name**
- **Your target customer** (ICP)
- **Your top 3 differentiators** vs this competitor
- **Common objections** when competing against them
- **Known competitor weaknesses**

## Output Structure

---

# Battlecard: [Your Product] vs [Competitor]
Updated: [Date] — Review quarterly

---

### In One Sentence
When a prospect mentions [Competitor], say: "[Your positioning in one sentence]"

---

### Why Customers Choose [Competitor]
(Be honest about their genuine strengths)
- [Strength 1]
- [Strength 2]

---

### Why Customers Choose Us
(Specific differentiators with proof points)
- **[Differentiator 1]:** [Proof point — customer outcome or capability]
- **[Differentiator 2]:** [Proof point]

---

### Objection Responses

**"[Competitor] is cheaper"**
"You are right their list price is lower. What our customers find is [specific TCO difference]. [Customer] saw [result]. Should we explore total cost of ownership?"

**"We already use [Competitor]"**
"That is helpful. What is working well? [Listen] And what is one thing you wish was better?"

**"[Competitor] has [feature] you do not"**
"You are right. What problem are you solving with that feature? [Listen] Here is how our customers solve that..."

---

### Landmines to Plant
- "How do you currently handle [area where competitor is weak]?"
- "What happens when you need to [scenario competitor struggles with]?"

---

### Traps to Avoid
- Never badmouth [Competitor] directly
- Do not lead with features — lead with the prospect problem
- Do not claim you do everything better — be specific about where you win

---

### When We Win / When We Lose
We win when: [Scenario — e.g. customer prioritises outcome over price]
We lose when: [Honest scenario — e.g. primary driver is lowest upfront cost]

## Example Trigger Phrases
- "Build a battlecard against [competitor]"
- "Create a competitive cheat sheet for [competitor]"
- "Write objection handling for [competitor] comparisons"'

write_skill "pm-sales" "discovery-call-prep" '---
name: discovery-call-prep
description: "Prepare a structured discovery call plan for any prospect. Use when asked to prepare for a sales call, discovery call, prospect meeting, or first call with a potential customer. Produces a call brief with research, hypotheses, questions, and success criteria."
---

# Discovery Call Prep Skill

Produces a complete discovery call brief — research summary, call hypothesis, structured questions, and success criteria — so every call starts with context and ends with a clear next step.

## Required Inputs
- **Prospect company name**
- **Contact name and role**
- **Any known context** (how they found you, prior interaction)
- **Your product/solution** (one line)
- **Call duration** (15 / 30 / 45 / 60 min)

## Output Structure

---

# Discovery Call Brief
**Prospect:** [Company] | **Contact:** [Name, Title] | **Duration:** [X min]

---

### Research Summary
- What they do: [Product/service, customer, business model]
- Size: [Headcount, revenue if public]
- Stage: [Startup / Scaleup / Enterprise]
- Recent news: [Funding, launches, leadership changes — last 90 days]
- Contact background: [Role tenure, previous companies, LinkedIn activity]
- Likely priorities for someone in this role: [Based on title and stage]

---

### Call Hypothesis
Before the call write your best guess:
- **Their most likely pain:** [What someone in this role at this company probably has]
- **Why they would care about us:** [Specific connection to your value]
- **Biggest risk to the deal:** [What might make this not a fit]

Write it down — then test it on the call.

---

### Call Agenda
"Here is what I was thinking for our [X] minutes:
- 2 min: Quick intros
- [X] min: Learn more about your situation
- [X] min: Share how we have helped similar companies
- 5 min: Next steps
Does that work? Anything specific you would like to cover?"

---

### Discovery Questions

Open with context (not a pitch):
- "What prompted you to take this call today?"
- "What does [relevant area] look like for you at the moment?"

Go deeper on pain:
- "How long has [problem] been an issue?"
- "What have you tried to solve it?"
- "What is the impact of not solving this?"

Understand buying context:
- "Who else would be involved in a decision like this?"
- "Have you looked at other solutions?"
- "Is there a reason you are exploring this now?"

Qualify on budget:
- "Have you set aside budget for this kind of initiative?"

Close discovery:
- "Based on what you have told me, it sounds like [summary]. Is that right?"

---

### Success Criteria
This call is successful if we leave with:
- Understanding of specific pain and business impact
- Knowledge of buying process and key stakeholders
- A clear agreed next step (demo / proposal / intro)
- Sense of timeline

This call is NOT successful if we only pitched and got "sounds interesting, send me some info."

---

### Suggested Next Step
"Based on what we discussed, the logical next step would be [specific]. Does [day/time] work?"

## Example Trigger Phrases
- "Prepare me for a discovery call with [company/contact]"
- "Build a call brief for my meeting with [name] at [company]"
- "What questions should I ask in a discovery call for [use case]?"'

write_skill "pm-sales" "proposal-writer" '---
name: proposal-writer
description: "Write a structured sales proposal or commercial proposal for any deal. Use when asked to write a proposal, sales proposal, commercial proposal, statement of work, or quote document. Produces a complete proposal with problem statement, solution, investment, and next steps."
---

# Proposal Writer Skill

Writes commercial proposals that win business — structured around the prospect problem, not the product.

## Required Inputs
- **Prospect company and contact**
- **Their problem or goal** (from discovery — be specific)
- **Your proposed solution**
- **Commercial terms** (pricing, payment terms, contract length)
- **Timeline**
- **Key stakeholders** who will read this
- **Tone** (formal / conversational / technical)

## Output Structure

---

# Proposal: [Brief description of what you are solving]
**Prepared for:** [Contact, Title] | [Company]
**Prepared by:** [Name] | [Your Company]
**Date:** [Date] | **Valid until:** [Date]

---

### Understanding Your Situation
[2-3 paragraphs. Demonstrate you listened. Describe their situation, problem, and impact of not solving it in their words. This section should make them think "yes, exactly." Generic boilerplate here = proposal goes in the bin.]

**The key challenge:** [One sentence — the core problem]
**The impact:** [What this costs them]
**What you have tried:** [Acknowledge prior attempts]

---

### Our Proposed Approach

**What we will do** (3-5 deliverables or phases)

**Phase 1: [Name]** (Timeline: [Weeks 1-2])
[What happens, what is delivered, what customer input is needed]

**Phase 2: [Name]** (Timeline: [Weeks 3-6])

**What you will get** (outcomes, not features)
- [Outcome 1]
- [Outcome 2]

**What success looks like**
[How both parties know this worked]

---

### Why [Your Company]
[3-4 sentences. Specific to their situation. Reference similar customers. Generic "why us" sections are skipped.]

---

### Investment

| Item | Description | Investment |
|---|---|---|
| [Component 1] | [Description] | £[amount] |
| **Total** | | **£[total]** |

**Payment terms:** [Terms]
**Included:** [What is in]
**Not included:** [What is out — prevents scope disputes]

---

### Timeline
| Milestone | Date |
|---|---|
| Contract signed | [Date] |
| Kickoff | [Date] |
| Delivery | [Date] |

---

### Next Steps
1. [Sign / reply / schedule] by [date]
2. We will send contract and confirm kickoff
3. [Any immediate action]

## Example Trigger Phrases
- "Write a proposal for [prospect] to [solve their problem]"
- "Draft a statement of work for [project]"
- "Turn my discovery notes into a proposal"'

write_skill "pm-sales" "account-plan" '---
name: account-plan
description: "Build a structured account plan for any key customer or target account. Use when asked to create an account plan, key account strategy, strategic account review, or territory plan. Produces a complete account plan with relationship map, growth opportunities, risks, and 90-day action plan."
---

# Account Plan Skill

Produces a structured account plan — the document that separates account managers who grow accounts from those who just service them.

## Required Inputs
- **Account name**
- **Current ARR / revenue**
- **Contract renewal date**
- **Key contacts** (names, roles, relationship strength)
- **Products/services currently in use**
- **Known opportunities or expansion areas**
- **Known risks**
- **Planning horizon** (6 / 12 / 24 months)

## Output Structure

---

# Account Plan: [Account Name]
**Account Manager:** [Name] | **Period:** [Date range]

---

### Account Snapshot

| Metric | Current | Target (EOY) |
|---|---|---|
| ARR / Revenue | £[amount] | £[target] |
| NPS / Health score | [Score] | [Target] |
| Products in use | [List] | [Expansion targets] |
| Renewal date | [Date] | — |
| Risk level | Low / Medium / High | — |

---

### Relationship Map

| Name | Title | Influence | Relationship | Notes |
|---|---|---|---|---|
| [Name] | [Role] | Decision maker / Influencer / User | Strong / Neutral / Weak | [Insight] |

**Relationship gaps:** [Who we do not have access to that we should]
**Executive sponsor:** [Do we have one? If not — who could become one?]

---

### Why They Stay (Retention Anchors)
[2-3 specific reasons this account renews. If the list is short, that is the risk signal.]

---

### Growth Opportunities

| Opportunity | Product | Est. Value | Timeline | Next Action |
|---|---|---|---|---|
| [Opportunity] | [Product] | £[value] | [Q/Year] | [Specific action] |

**Whitespace:** What products do we have that this account does not use, and why?

---

### Risks and Mitigation

| Risk | Likelihood | Impact | Mitigation | Owner |
|---|---|---|---|---|
| [Risk] | H/M/L | H/M/L | [Action] | [Name] |

---

### 90-Day Action Plan

| Action | Why | Owner | Due |
|---|---|---|---|
| [Specific action] | [Why it matters] | [Name] | [Date] |

**Next QBR / EBR:** [Date — if no EBR cadence, flag as a risk]

---

### Success Criteria
At end of [period]:
- Renewed at or above current ARR
- [Expansion opportunity] progressed to [stage]
- Health score moved from [current] to [target]

## Example Trigger Phrases
- "Build an account plan for [customer]"
- "Create a key account strategy for [account]"
- "Help me plan my approach to renewing [account]"'

echo ""

# =============================================================================
# BUNDLE: pm-operations
# =============================================================================
echo "Creating pm-operations bundle..."
mkdir -p plugins/pm-operations/.claude-plugin

cat > plugins/pm-operations/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-operations",
  "version": "1.0.0",
  "description": "Operations skills: Process Documentation, SOP Writer, Vendor Evaluation, Project Status Report. Document workflows, write audit-ready SOPs, evaluate vendors with weighted scorecards, and produce RAG status reports.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["operations", "process", "sop", "vendor", "procurement", "project-management", "rag-status"]
}
EOF

write_skill "pm-operations" "process-documentation" '---
name: process-documentation
description: "Document any business process in a clear, structured format. Use when asked to document a process, write a process guide, create a workflow document, or map out how something works. Produces a complete process document with steps, roles, inputs, outputs, and edge cases."
---

# Process Documentation Skill

Produces clear, structured process documentation that someone new to a role can follow without needing to ask questions.

## Required Inputs
- **Process name**
- **Process description** (rough notes are fine)
- **Who does this process** (roles involved)
- **How often it runs** (daily / weekly / monthly / event-triggered)
- **Tools involved**
- **Known edge cases**

## Output Structure

---

# Process: [Process Name]
**Owner:** [Role] | **Frequency:** [How often] | **Estimated time:** [Duration]

---

### Purpose
[1-2 sentences. Why does this process exist? What breaks if it is not done?]

### Scope
**In scope:** [What this covers]
**Out of scope:** [What it does not cover]

### Prerequisites
- [ ] [Required access or information]
- [ ] [Any dependency that must be completed first]

---

### Roles and Responsibilities

| Role | Responsibility |
|---|---|
| [Role 1] | [What they do] |

---

### Process Steps

**Step 1: [Step name]**
- **Who:** [Role]
- **When:** [Trigger or timing]
- **How:** [Substeps numbered]
- **Output:** [What exists at end of this step]
- **Tool:** [System used]

[Continue for all steps]

---

### Edge Cases and Exceptions

| Situation | What to do | Who to contact |
|---|---|---|
| [Edge case] | [Action] | [Name/role] |

---

### Common Mistakes
[2-4 things people get wrong the first time]

### Escalation Path
[Name/role] → [Next level] → [Final escalation]

### Review
Next review due: [Date]

## Example Trigger Phrases
- "Document this process: [description]"
- "Write a process guide for [workflow]"
- "Map out how [process] works"'

write_skill "pm-operations" "sop-writer" '---
name: sop-writer
description: "Write a Standard Operating Procedure (SOP) for any operational task. Use when asked to write an SOP, standard operating procedure, work instruction, or operating manual. Produces a formal SOP with purpose, scope, procedure steps, quality checks, and version control."
---

# SOP Writer Skill

Produces formal, audit-ready SOPs suitable for regulated industries, ISO certification, or operational scaling.

## Required Inputs
- **SOP title** (e.g. "SOP-001: New Client Onboarding")
- **Department / function**
- **Process description**
- **Regulatory or quality standard** (ISO 9001, GMP, CQC, FCA, etc.)
- **Roles involved**
- **Tools or equipment used**

## Output Structure

---

**[COMPANY NAME] — Standard Operating Procedure**

| Document ID | [SOP-XXX] |
|---|---|
| Title | [Title] |
| Department | [Department] |
| Version | 1.0 |
| Effective date | [Date] |
| Review date | [Date] |
| Status | Draft / Under review / Approved |

---

### 1. Purpose
[1-2 sentences. Why does this SOP exist?]

### 2. Scope
**Applies to:** [Roles, departments, locations]
**Does not apply to:** [Explicit exclusions]

### 3. Definitions
| Term | Definition |
|---|---|
| [Term] | [Plain English definition] |

### 4. Responsibilities
| Role | Responsibility |
|---|---|
| [Role] | [Specific responsibility] |

### 5. Required Materials / Tools / Access
- [Item]

### 6. Procedure

| Step | Action | Responsible | Record/Output |
|---|---|---|---|
| 6.1.1 | [Imperative action: "Open [system] and navigate to [location]"] | [Role] | [What to record] |

NOTE: Steps must be written in imperative form. Each step must have one action only.

### 7. Quality Checks

| Check point | What to verify | Pass criteria | If fail |
|---|---|---|---|
| [After step X] | [What to check] | [What good looks like] | [What to do] |

### 8. Non-Conformance
1. [Immediate action]
2. [Who to notify]
3. [How to document deviation]

### 9. References
[Related SOPs, policies, standards]

### 10. Document History

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | [Date] | [Name] | Initial release |

## Quality Checks
- All steps in imperative form
- Each step has exactly one action
- Roles specified for every step
- Quality checkpoints at critical stages
- Non-conformance process defined

## Example Trigger Phrases
- "Write an SOP for [process]"
- "Create a standard operating procedure for [task]"
- "Write a work instruction for [process]"'

write_skill "pm-operations" "vendor-evaluation" '---
name: vendor-evaluation
description: "Create a structured vendor evaluation framework for any procurement decision. Use when asked to evaluate vendors, compare suppliers, run an RFP scoring process, or assess a software or service provider. Produces a weighted scorecard, evaluation criteria, and recommendation framework."
---

# Vendor Evaluation Skill

Produces a structured vendor evaluation framework — from defining criteria through to a scored comparison and recommendation.

## Required Inputs
- **What you are procuring**
- **Vendors being evaluated** (minimum 2)
- **Key decision criteria** (if known)
- **Decision makers**
- **Budget range**
- **Timeline to decide**

## Output Structure

### 1. Evaluation Criteria and Weights

| Category | Weight | Rationale |
|---|---|---|
| Functional fit | [%] | Does it do what we need? |
| Commercial terms | [%] | Price, flexibility, payment |
| Implementation | [%] | How hard to get started? |
| Support and SLA | [%] | What happens when things go wrong? |
| Security and compliance | [%] | Meets regulatory requirements? |
| Vendor stability | [%] | Will this company exist in 3 years? |
| References | [%] | Who else uses this? |

Weights must total 100%.

### 2. Scoring Rubric
- 5: Exceeds requirements — clear best-in-class
- 4: Meets requirements — fully satisfies with minor gaps
- 3: Partially meets — notable gaps requiring workarounds
- 2: Significant gaps — would require workarounds
- 1: Does not meet — cannot satisfy requirement

### 3. Vendor Scorecard

| Criterion | Weight | [Vendor A] | Weighted | [Vendor B] | Weighted | [Vendor C] | Weighted |
|---|---|---|---|---|---|---|---|
| Functional fit | [%] | /5 | | /5 | | /5 | |
| [Continue...] | | | | | | | |
| **Total** | 100% | | **/5** | | **/5** | | **/5** |

### 4. Key Questions for Every Vendor
Functional: Walk through [most critical use case]. What can your product not do that customers ask for?
Commercial: What is included vs add-ons? Contract minimum term and notice period? Price protection at renewal?
Implementation: Typical implementation for our size? What do you need from our team?
Support: SLA for critical issues? Support included vs charged extra?
Security: ISO 27001 / SOC 2 certified? Where is data stored? Breach notification process?

### 5. Reference Check Questions
- How long using [vendor]? Implementation surprises? Support responsiveness? One thing you wish you had known? Would you choose them again?

### 6. Recommendation

**Recommended vendor:** [Name] | **Score:** [X/5]
**Rationale:** [Specific strengths that matter for this decision]
**Key risks:** [Risk and mitigation]
**Conditions:** [Contract terms to negotiate before signing]
**Runner-up:** [Vendor and why they lost]

## Example Trigger Phrases
- "Help me evaluate vendors for [procurement]"
- "Create a vendor scorecard for [software/service]"
- "Compare [Vendor A] vs [Vendor B] for [use case]"'

write_skill "pm-operations" "project-status-report" '---
name: project-status-report
description: "Write a structured project status report for any project. Use when asked to write a project update, status report, RAG report, project dashboard narrative, or weekly project communication. Produces a clear status report with RAG ratings, milestone progress, risks, and decisions needed."
---

# Project Status Report Skill

Produces a clear, structured project status report — the weekly communication that keeps stakeholders informed without requiring a meeting.

## Required Inputs
- **Project name**
- **Reporting period**
- **Current RAG status** (Red / Amber / Green)
- **Key milestones** (due, delivered, coming)
- **Issues or blockers**
- **Decisions needed from stakeholders**
- **Budget status** (if tracked)
- **Audience** (steering committee / sponsor / PMO / full team)

## Output Structure

---

# Project Status Report: [Project Name]
**Period:** [Date range] | **Author:** [PM] | **Next report:** [Date]

---

### Overall Status

| Dimension | Status | Last period | Trend |
|---|---|---|---|
| Overall | Red / Amber / Green | [Last] | Improving / Stable / Declining |
| Schedule | | | |
| Budget | | | |
| Scope | | | |
| Risks | | | |

RAG definitions:
- Green: On track. No significant issues.
- Amber: At risk. Issues identified but mitigations in place.
- Red: Off track. Escalation or decisions required to recover.

---

### Executive Summary
[3-5 sentences. Headline story. If it is Red, say so immediately and why. Never bury bad news after good news.]

---

### Milestone Progress

| Milestone | Due date | Status | Comment |
|---|---|---|---|
| [Milestone] | [Date] | Complete / At risk / Delayed / On track | [One line] |

**Completed this period:** [What was delivered]
**Due next period:** [What is expected]

---

### Issues and Blockers

**[Issue title] — Critical / High / Low**
- **Description:** [What the issue is]
- **Impact:** [What happens if unresolved]
- **Owner:** [Who is resolving]
- **Action:** [What is being done]
- **Resolution date:** [When it will be closed]

---

### Risks

| Risk | Likelihood | Impact | Mitigation | Owner |
|---|---|---|---|---|
| [Risk] | H/M/L | H/M/L | [Action] | [Name] |

---

### Decisions Required

| Decision | Background | Options | Recommendation | Needed by |
|---|---|---|---|---|
| [Decision] | [Context] | [Options] | [Recommendation] | [Date] |

---

### Budget Summary

| | Budget | Actual to date | Forecast | Variance |
|---|---|---|---|---|
| Total | £ | £ | £ | £ F/A |

---

### Next Period Plan
[3-5 specific bullet points — what will happen next period]

## Writing Rules
- Never soften a Red status
- Milestones are binary: complete or not complete
- Decisions must be genuinely actionable
- Keep to one page where possible

## Example Trigger Phrases
- "Write a project status report for [project]"
- "Generate a RAG status update for [project]"
- "Write the steering committee report for [project]"'

echo ""

# =============================================================================
# BUNDLE: pm-research
# =============================================================================
echo "Creating pm-research bundle..."
mkdir -p plugins/pm-research/.claude-plugin

cat > plugins/pm-research/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-research",
  "version": "1.0.0",
  "description": "Research and healthcare skills: Clinical Case Summary, Research Protocol, Patient Communication, Literature Review. Write SBAR handovers, design research protocols, draft accessible patient communications, and structure literature reviews.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["research", "healthcare", "clinical", "patient", "literature-review", "protocol", "academic"]
}
EOF

write_skill "pm-research" "clinical-case-summary" '---
name: clinical-case-summary
description: "Write a structured clinical case summary or case presentation. Use when asked to write a clinical case summary, case presentation, patient case report, or clinical handover. Produces a structured summary using SBAR or SOAP format. For educational and documentation purposes only — not a substitute for clinical judgement."
---

# Clinical Case Summary Skill

Produces structured clinical case summaries for educational, documentation, and handover purposes.

WARNING: For documentation and educational purposes only. All clinical content must be reviewed by a qualified healthcare professional. This is not clinical advice.

## Required Inputs
- **Purpose** (case presentation / handover / case report / educational / MDT summary)
- **Patient details** (anonymised — age, sex, relevant background)
- **Presenting complaint and history**
- **Examination findings**
- **Investigations and results**
- **Diagnosis or differential diagnoses**
- **Management and treatment**
- **Outcome** (if known)
- **Format preference** (SBAR / SOAP / Standard clinical / Narrative)

---

## Format A: SBAR (Handover / Referral)

**S — Situation**
[Patient identifier anonymised, location, reason for contact in one sentence]

**B — Background**
- Age / sex / relevant past medical history
- Current admission details
- Relevant medications and allergies
- Brief relevant social history

**A — Assessment**
- Current clinical status
- Vital signs if relevant
- Key examination findings
- Working diagnosis or differential
- Recent investigations and results

**R — Recommendation**
- What you need from the recipient
- Urgency level
- Immediate actions already taken
- Questions or concerns

---

## Format B: SOAP Note

**S — Subjective**
[Presenting complaint in patient words. Symptom history: onset, duration, character, severity, associated symptoms, relieving/aggravating factors]

**O — Objective**
- Vital signs: [BP, HR, RR, Temp, O2 sats]
- Examination: [Systematic findings]
- Investigations: [Results with reference ranges]

**A — Assessment**
- Primary diagnosis: [With brief rationale]
- Differential diagnoses: [Ranked with reasoning]

**P — Plan**
- Immediate management
- Investigations ordered
- Treatments initiated with dose, route, frequency
- Referrals
- Safety netting: what to watch for, when to escalate
- Follow-up plan

## Quality Checks
- Patient details fully anonymised
- Allergies and medications included in handover formats
- Safety netting included in SOAP plan
- Disclaimer included

## Example Trigger Phrases
- "Write a clinical handover using SBAR for this patient"
- "Summarise this case in SOAP format"
- "Write a case report for [clinical scenario]"
- "Prepare an MDT summary for this patient"'

write_skill "pm-research" "research-protocol" '---
name: research-protocol
description: "Write a structured research protocol or study design document. Use when asked to write a research protocol, study protocol, research plan, methodology section, or research proposal. Produces a complete protocol with objectives, methodology, ethical considerations, and analysis plan."
---

# Research Protocol Skill

Produces structured research protocols for academic, clinical, social science, or market research studies.

## Required Inputs
- **Research type** (clinical trial / observational / qualitative / systematic review / survey)
- **Research question or hypothesis**
- **Setting and population**
- **Proposed methodology**
- **Timeline**
- **Funder or institution** (if applicable)

## Output Structure

---

# Research Protocol: [Study Title]
**Version:** 1.0 | **Date:** [Date] | **PI:** [Name, institution]

---

### 1. Background and Rationale
- What is already known
- What the gap in knowledge is
- Why this study is needed now

### 2. Research Objectives
**Primary:** [One clear answerable question or hypothesis]
**Secondary:** [Additional questions]

### 3. Study Design
- **Design:** [RCT / cohort / qualitative / mixed methods]
- **Setting:** [Where]
- **Duration:** [Total period and recruitment window]
- **Rationale:** [Why this design fits the question]

### 4. Participants

**Inclusion criteria:** [List]
**Exclusion criteria:** [List]
**Sample size:** [n] — Basis: [Power calculation or saturation rationale]
**Recruitment:** [Method and source]

### 5. Methodology / Intervention

For interventional: intervention description, control, randomisation, blinding
For observational/qualitative: data collection methods, tools, data collectors

### 6. Outcomes / Measures
**Primary outcome:** [Measure], assessed by [method], at [timepoint]
**Secondary outcomes:** [Measure], [method], [timepoint]

### 7. Data Management
- Storage: [Where and anonymisation method]
- Access controls: [Who can access]
- Retention: [How long]

### 8. Analysis Plan
Quantitative: [Statistical test], [missing data handling], [software]
Qualitative: [Framework — e.g. Braun & Clarke], [quality assurance]

### 9. Ethical Considerations
- Ethics approval: [Body / reference]
- Informed consent: [Process]
- Confidentiality: [How maintained]
- Risk to participants: [Assessment and mitigation]

### 10. Dissemination Plan
- Target journals: [2-3 relevant]
- Conference presentations
- Public/patient summary

### 11. Timeline

| Phase | Activities | Start | End |
|---|---|---|---|
| Setup | Ethics, approvals, tool development | | |
| Recruitment | | | |
| Data collection | | | |
| Analysis | | | |
| Write-up | | | |

## Quality Checks
- Primary objective is singular and answerable
- Sample size has stated basis
- Ethical considerations complete
- Analysis plan pre-specified

## Example Trigger Phrases
- "Write a research protocol for [study]"
- "Help me design a study to investigate [question]"
- "Write the methodology for my research proposal"'

write_skill "pm-research" "patient-communication" '---
name: patient-communication
description: "Write clear, plain English patient communications for any healthcare context. Use when asked to write a patient letter, patient information leaflet, appointment letter, test results letter, discharge summary for patients, or health education content. Targets accessible reading level with clear next steps."
---

# Patient Communication Skill

Writes patient-facing healthcare communications in plain, accessible language — targeting UK Grade 6 / US Grade 8 reading level.

WARNING: All patient communications must be reviewed and approved by a qualified healthcare professional before sending. This skill produces drafts only.

## Required Inputs
- **Communication type** (appointment letter / results letter / discharge info / patient leaflet / consent info / health education)
- **Clinical context**
- **Key messages** (what the patient must understand and do)
- **Tone** (reassuring / informative / urgent)
- **Specific instructions or next steps**
- **Contact details for queries**

## Output Structure

### Type A: Patient Letter

[Date]

Dear [Patient name],

**Re: [Clear subject line in bold]**

[Opening paragraph: State clearly what this letter is about. No preamble.]

[Main content — short paragraphs, 2-3 sentences each. Bullet points for instructions. Bold anything the patient must do or remember.]

**What happens next:**
- [Action 1 — specific with timeframe]
- [Action 2]

**If you have questions:**
Contact us at [phone] between [hours] or email [address].

If you feel unwell before your appointment, please [specific instruction].

Yours sincerely, [Name, Title, Department]

---

### Type B: Patient Information Leaflet

**[Plain language title]**

**What is [topic]?** [2-3 plain English sentences. Explain technical terms immediately.]

**Why has this been recommended for me?** [Personalised clinical reason in patient terms]

**What will happen?** [Numbered step by step]

**What are the benefits?** [Honest statement]

**What are the risks?** [Common first, then rare but serious. Use frequencies: "About 1 in 10 people..." not "10% incidence"]

**What should I do to prepare?** [Specific instructions]

**When should I contact someone?** [Specific signs — not vague. "Temperature above 38C" not "if you feel unwell"]

---

### Type C: Test Results Letter

**Your [test name] results — [Normal / Abnormal] — stated in the FIRST sentence, never paragraph 3.**

[What this means in plain English]

**What happens next:** [Clear next steps. If no action, say so explicitly.]

---

## Plain Language Rules (apply to all types)
- Maximum 2 syllables per word where possible
- Maximum 20 words per sentence
- Active voice: "We will contact you" not "You will be contacted"
- Spell out all acronyms on first use
- No Latin: "twice daily" not "bd"
- Use "you" and "we" throughout
- Numbers as digits: "2 tablets" not "two tablets"

## Example Trigger Phrases
- "Write a patient letter about [topic]"
- "Create a patient information leaflet for [procedure]"
- "Write a plain English results letter for [test]"'

write_skill "pm-research" "literature-review" '---
name: literature-review
description: "Structure and write a literature review for any research topic. Use when asked to write a literature review, systematic review summary, narrative review, or research background section. Produces a structured review with thematic organisation, critical analysis, and gap identification."
---

# Literature Review Skill

Structures and writes literature reviews — from background sections of a dissertation through to standalone narrative reviews for publication.

## Required Inputs
- **Topic or research question**
- **Type of review** (narrative / systematic / scoping / integrative / background section)
- **Sources provided** (paste references, abstracts, or key findings)
- **Word count target**
- **Audience** (academic journal / thesis / grant proposal / policy brief)
- **Time period to cover**

## Output Structure

### 1. Search Strategy Summary (for systematic/scoping reviews)
**Databases:** [PubMed, EMBASE, PsycINFO, etc.]
**Search terms:** [Key terms and Boolean combinations]
**Inclusion criteria:** Study types, population, date range, language
**Exclusion criteria:** [List]
**Results:** [n] identified → [n] after deduplication → [n] screened → [n] included

### 2. Literature Review Body

Organised thematically — not chronologically. Each theme = one section.

**Structure per thematic section:**

**[Theme heading]**

[Opening: state what this section covers and what evidence shows overall]

[Evidence synthesis: present what multiple studies found, compare and contrast. Do NOT summarise one paper then the next — synthesise across them: "Three studies found X (Smith, 2019; Jones, 2020; Lee, 2021), while two found Y, with the difference attributable to..."]

[Critical analysis: note methodological strengths and weaknesses — sample sizes, study designs, generalisability, risk of bias]

[Closing: transition to next theme]

### 3. Synthesis Table (systematic/scoping reviews)

| Author, year | Study design | Population | n | Key findings | Quality/Limitations |
|---|---|---|---|---|---|

### 4. Gap Analysis

**Well-established:** [What literature consistently shows]
**Contested:** [Areas where evidence is mixed and why]
**Missing:** [Gaps the field needs to address]
**How your study addresses the gap:** [If this is for a research proposal]

### 5. Conclusion Paragraph
[3-5 sentences. Current state of knowledge and what is needed next]

## Critical Analysis Framework
For each paper: internal validity, external validity, bias types, effect size significance vs clinical significance, funding conflicts.

## Quality Checks
- Organised thematically not as paper summaries
- Evidence synthesised across papers
- Critical analysis included
- Gaps identified
- All claims cited

## Example Trigger Phrases
- "Write a literature review on [topic]"
- "Synthesise the evidence on [topic] from these papers: [paste]"
- "Write the background section for my research proposal on [topic]"'

echo ""

# =============================================================================
# BUNDLE: pm-cross
# =============================================================================
echo "Creating pm-cross bundle..."
mkdir -p plugins/pm-cross/.claude-plugin

cat > plugins/pm-cross/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-cross",
  "version": "1.0.0",
  "description": "Cross-profession skills: Press Release, Grant Proposal, Executive Summary. Write journalist-ready press releases, structure grant applications aligned to funder priorities, and produce decision-ready executive summaries for any audience.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["communications", "press-release", "grant", "executive-summary", "briefing", "funding", "media"]
}
EOF

write_skill "pm-cross" "press-release" '---
name: press-release
description: "Write a professional press release for any announcement. Use when asked to write a press release, media announcement, news release, or press statement. Produces a structured press release with headline, dateline, body, boilerplate, and media contact — ready to send to journalists."
---

# Press Release Skill

Writes press releases that journalists actually read — structured around the news angle, not the desire to promote.

## Required Inputs
- **The news** (what is actually happening — be specific)
- **Company name**
- **Date of announcement / embargo date**
- **Key quote** (from which executive and approximately what they want to say)
- **Why this matters** (to the reader, not the company)
- **Target media** (trade / national / local / consumer / investor)
- **Media contact details**

## Output Structure

---

FOR IMMEDIATE RELEASE / EMBARGOED UNTIL: [Date and time]

---

# [Headline — active verb, specific news, under 10 words]
## [Subheadline — the so-what in one sentence, adds context not repetition]

**[City, Date]** — [Opening paragraph: Who, What, When, Where, Why in 2-3 sentences. A journalist should be able to run this paragraph alone. No background, no context, no company history.]

[Second paragraph: the significance. Why does this matter? What does it mean for customers or the industry?]

[Third paragraph: quote from executive. Human and specific. Not a restatement of the headline.]

"[Quote text — specific, adds something the facts do not say]," said [Name], [Title] at [Company]. "[Second sentence extending the thought]."

[Fourth paragraph: supporting detail — data, customer names with permission, additional context]

[Fifth paragraph optional: what happens next, when it goes live, what people can do]

---

ENDS

---

**Notes to editors:**

**About [Company]**
[Boilerplate: 3-4 sentences. What the company does, when founded, where based, key facts. Factual not promotional.]

**Media contact:**
[Name] | [Title] | [Email] | [Phone] | [Hours/timezone]

---

## Headline Rules
- Active voice: "Company launches X" not "X is launched by Company"
- Specific: "raises 5M" not "secures significant investment"
- Under 10 words
- Never start with the company name — lead with the news

## Journalist Test
Would a journalist care? Is the headline the full story? Is there a human angle? Is the quote something a human would say? Can the first paragraph stand alone?

## Example Trigger Phrases
- "Write a press release announcing [news]"
- "Draft a media statement about [event]"
- "We are launching [product] — write the press release"
- "Turn this announcement into a press release: [paste notes]"'

write_skill "pm-cross" "grant-proposal" '---
name: grant-proposal
description: "Write a structured grant proposal or funding application for any grant type. Use when asked to write a grant proposal, funding application, research grant, charitable grant, or innovation fund application. Produces a complete proposal with project summary, rationale, methodology, impact, and budget narrative."
---

# Grant Proposal Skill

Produces structured grant proposals tailored to the funder priorities — the most common reason grants fail is writing about what you want to do rather than what the funder wants to fund.

## Required Inputs
- **Funder name and grant programme**
- **Grant amount sought**
- **Project description** (rough notes are fine)
- **Your organisation** (type, track record, capacity)
- **Funder stated priorities** (copy from their guidance — essential)
- **Word or page limits**
- **Deadline**

## Output Structure

---

### Project Title
[Informative and memorable. Should convey the problem being solved and the approach.]

### 1. Project Summary / Abstract (200-300 words — written last, placed first)
[What you will do, why it matters, who will benefit, measurable outcomes. Every sentence earns its place.]

### 2. Problem Statement / Need
- **The problem:** [Specific, evidenced — use data]
- **Who is affected:** [Population, scale, geography]
- **Current situation:** [What exists and why it is insufficient]
- **Consequence of inaction:** [What happens if not funded]
- **Why your organisation:** [Track record, relationships, expertise]

Funder test: does this problem align with [funder] stated priorities? Make the connection explicit.

### 3. Project Objectives
3-5 SMART objectives:
- **Objective 1:** [Specific, Measurable, Achievable, Relevant, Time-bound]

### 4. Methodology / Approach

**Phase 1: [Name]** (Months 1-X)
[What will happen, who will do it, what is produced]

**Key activities:**
- [Activity — specific]

**What makes this approach innovative or effective:** [Why this over alternatives]

### 5. Impact and Outcomes

| Level | Description | Measure |
|---|---|---|
| Output | [Tangible deliverable] | [How counted] |
| Short-term outcome | [Immediate change] | [How measured] |
| Medium-term outcome | [Behaviour change] | [How measured] |
| Long-term impact | [Systemic change] | [How evidenced] |

**Direct beneficiaries:** [Who and how many]
**Sustainability:** [How work continues beyond grant period]

### 6. Evaluation Plan
- Who evaluates, how, when, what is measured, how findings are shared

### 7. Budget Narrative

| Budget line | Amount | Justification |
|---|---|---|
| Staff costs | £[amount] | [Role, % FTE, duration, salary] |
| Travel | £[amount] | [Specific journeys named] |
| Equipment | £[amount] | [Itemised] |
| Indirect costs | £[amount] | [[X]% of direct — check policy] |
| **Total** | **£[total]** | |

**Value for money:** [Cost per beneficiary. What could not be done without this grant]

### 8. Organisational Capacity
[Track record of similar projects, governance, financial management. Name previous grants and outputs — be specific]

### 9. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| [Risk] | H/M/L | H/M/L | [Specific mitigation] |

---

## Funder Alignment Check
- Every section explicitly references funder stated priorities
- Word limits respected
- Budget aligns with eligible costs policy
- Required attachments prepared

## Example Trigger Phrases
- "Write a grant proposal for [project] applying to [funder]"
- "Help me write a funding application for [grant programme]"
- "Turn these project notes into a grant proposal: [paste]"'

write_skill "pm-cross" "executive-summary" '---
name: executive-summary
description: "Write an executive summary for any document, report, or proposal. Use when asked to write an executive summary, management summary, briefing paper, or one-pager for senior stakeholders. Produces a structured summary that busy executives can read in under 3 minutes and act on."
---

# Executive Summary Skill

Writes executive summaries that busy decision-makers actually read — front-loaded with conclusions, structured for skimming, ruthless about what to include.

## Required Inputs
- **Source document or topic** (paste or describe)
- **Audience** (CEO / board / investor / minister / client / committee)
- **Decision or action needed** (what should the reader do after reading?)
- **Length limit** (1 page / 2 pages / 500 words)
- **Format** (formal report / slide / email / briefing paper)

## Core Principle

An executive summary is NOT a summary of the document. It is a standalone document that:
- States the conclusion upfront — not at the end
- Contains only what the reader needs to make a decision
- Can be understood without reading anything else
- Recommends a specific action

## Output Structure

---

### [Title]
**Executive Summary**
*Prepared for: [Audience] | Date: [Date] | Author: [Name]*

---

**Bottom line up front:**
[The most important thing. The recommendation or finding. 2-3 sentences. A reader who only reads this should know what you are asking or telling them.]

---

**Background (why this matters):**
[2-3 sentences. Minimum context to understand the bottom line. Not the history — just what the reader needs now.]

---

**Key findings / analysis:**
- **[Finding 1]:** [One sentence — specific and evidence-based]
- **[Finding 2]:** [One sentence]
- **[Finding 3]:** [One sentence]

---

**Options considered:** (include only if a decision is being presented)

| Option | Benefit | Risk | Recommendation |
|---|---|---|---|
| [Option A] | [Benefit] | [Risk] | Recommended |
| [Option B] | [Benefit] | [Risk] | Not recommended |

---

**Recommendation:**
[Specific. "We recommend [action] because [reason]. This will [outcome]." Not "we suggest consideration of options."]

---

**Immediate next steps:**
- [Action 1 — specific, with owner and date]
- [Action 2]

---

**Risks of inaction:** [What happens if the reader does nothing]

**Full report:** [Reference to where the full document can be found]

---

## Adapting for Different Audiences

**CEO/MD:** Lead with financial or strategic impact. 1 page. Make the decision binary. Ask in sentence one.
**Board:** Lead with governance or risk. Frame against organisational objectives. State specifically what you need from them.
**Investor:** Lead with return or opportunity. Specific numbers. 1 page. Anticipate "why now."
**Minister/senior public sector:** Lead with public benefit or policy alignment. Include cost-benefit framing.
**Client:** Lead with their problem. Show you understand before presenting recommendation.

## Quality Checks
- Bottom line in first 3 sentences
- Standalone — no need to read full document
- Recommendation is specific
- Fits length limit
- Written for audience priorities not author priorities
- Next steps have owners and dates

## Example Trigger Phrases
- "Write an executive summary of this report: [paste]"
- "Summarise this document for the board: [paste]"
- "Create a one-pager from this proposal for the CEO"
- "Turn these findings into an exec summary"'

echo ""

# =============================================================================
# FINAL VERIFICATION
# =============================================================================
echo "================================================"
echo " Verifying all files created..."
echo ""

SKILL_COUNT=$(find "$REPO_ROOT/skills" -name "SKILL.md" | wc -l)
PLUGIN_SKILL_COUNT=$(find "$REPO_ROOT/plugins" -name "SKILL.md" | wc -l)
PLUGIN_JSON_COUNT=$(find "$REPO_ROOT/plugins" -name "plugin.json" | wc -l)

echo " skills/ SKILL.md files:          $SKILL_COUNT"
echo " plugins/ SKILL.md files:         $PLUGIN_SKILL_COUNT"
echo " plugins/ plugin.json files:      $PLUGIN_JSON_COUNT"
echo ""
echo " New bundles created:"
echo "   plugins/pm-legal/"
echo "   plugins/pm-finance/"
echo "   plugins/pm-hr/"
echo "   plugins/pm-sales/"
echo "   plugins/pm-operations/"
echo "   plugins/pm-research/"
echo "   plugins/pm-cross/"
echo ""
echo "================================================"
echo " Done! Next steps:"
echo ""
echo " 1. Run update-marketplace.sh to add 7 new bundles"
echo "    to .claude-plugin/marketplace.json"
echo ""
echo " 2. git add ."
echo " 3. git commit -m 'feat: add 27 new skills across 7"
echo "    professions — 80 skills total (v5.0.0)'"
echo " 4. git push origin main"
echo ""
echo " 5. In Claude Code:"
echo "    /plugin marketplace remove mohitagw15856/pm-claude-skills"
echo "    /plugin marketplace add mohitagw15856/pm-claude-skills"
echo "================================================"
