---
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
- "Build an ISO 27001 gap analysis"
