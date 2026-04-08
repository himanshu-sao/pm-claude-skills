#!/bin/bash

# =============================================================================
# update-marketplace.sh
# Run from the ROOT of your pm-claude-skills repo.
# Rewrites .claude-plugin/marketplace.json — v5.1.0 — 22 plugins, 90 skills.
# =============================================================================

set -e

cat > .claude-plugin/marketplace.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "pm-claude-skills",
  "version": "5.1.0",
  "description": "90 Claude Skills across 14 professions — product management, marketing, engineering, data, design, Figma, leadership, legal, finance, HR, sales, operations, research, and more. Save 10-15 hours per week.",
  "owner": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "plugins": [
    {
      "name": "pm-essentials",
      "description": "Core PM skills: PRD Template, Meeting Notes, Stakeholder Update, User Research Synthesis, Competitive Analysis. The 5 skills every PM needs first.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-essentials",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-discovery",
      "description": "Discovery & research skills: Discovery Interview Guide, Job Story Mapper, User Interview Synthesis, Assumption Mapper. Structure user research from screener to synthesis.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-discovery",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-planning",
      "description": "Planning & strategy skills: OKR Builder, Feature Prioritisation (RICE/MoSCoW/Kano/ICE), Roadmap Presentation, Pricing Strategy, RICE + Impact Matrix, Roadmap Narrative.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-planning",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-delivery",
      "description": "Sprint & delivery skills: Sprint Planning, Technical Spec Template, A/B Test Planner, Go-to-Market Planner, Product Launch Checklist, Sprint Brief, Retro Analysis.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-delivery",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-analytics",
      "description": "Data & metrics skills: Data Analysis Standard, Retention Analysis, Product Health Analysis. Structure metric deep-dives, funnel analysis, cohort studies and churn investigations.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-analytics",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-strategy",
      "description": "Strategy & stakeholder skills: Competitor Signal Tracker, Competitive Intelligence Monitor, Stakeholder Influence Mapper, Strategic Narrative Generator, Executive Update, Ambiguity Resolver.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-strategy",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-advanced",
      "description": "Advanced PM skills: AI Product Canvas, Multi-Source Signal Synthesiser, Experiment Designer, Design Handoff Brief, Stakeholder Update. For senior PMs working on complex products.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-advanced",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-rituals",
      "description": "Weekly PM ritual skill: PM Weekly Review. A 20-minute structured ritual covering metrics, shipping progress, insights, and next week's top 3 priorities.",
      "version": "3.0.0",
      "category": "productivity",
      "source": "./plugins/pm-rituals",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-gtm",
      "description": "Marketing & GTM skills: Go-To-Market Planner, Content Calendar, Competitor Teardown, Email Campaign. Build positioning statements, messaging pillars, feature lists, use cases, and launch campaigns.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-gtm",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-engineering",
      "description": "Engineering & tech skills: Code Review Checklist, Incident Postmortem, API Docs Writer, Architecture Decision Record. Structured outputs for engineering teams and technical PMs.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-engineering",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-data",
      "description": "Data & analytics skills: Metrics Framework, SQL Query Explainer, Dashboard Brief. Build North Star metric trees, explain and optimise SQL, and spec dashboards from business questions.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-data",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-people",
      "description": "Leadership & people skills: Performance Review, Hiring Rubric, Team Offsite Planner. Write structured reviews, build interview scorecards, and plan offsites from goals to minute-by-minute agenda.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-people",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-design",
      "description": "Design & UX skills: UX Research Plan, Design Critique, Accessibility Audit. Create research plans with discussion guides, critique designs using JTBD and Gestalt principles, audit for WCAG 2.2 compliance.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-design",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-business",
      "description": "Business & strategy skills: Investor Update, Board Deck Narrative, Job Application. Write investor updates investors actually read, structure board presentations, and tailor CVs with ATS optimisation.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-business",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-legal",
      "description": "Legal skills: Contract Review, NDA Analyser, Legal Brief, Compliance Checklist. Flag risks in contracts and NDAs, draft legal memos in IRAC format, and generate GDPR, SOC 2, FCA and other compliance checklists.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-legal",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-finance",
      "description": "Finance skills: Financial Model Narrative, Budget Variance Analysis, Investor Pitch Deck, Financial Due Diligence. Turn numbers into board-ready narratives, explain variances, structure pitch decks, and generate DD checklists.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-finance",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-hr",
      "description": "HR skills: Job Description Writer, Onboarding Plan, Employee Engagement Survey, Redundancy Consultation. Write inclusive JDs, build 30/60/90-day plans, design engagement surveys, and structure legally compliant redundancy processes.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-hr",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-sales",
      "description": "Sales skills: Sales Battlecard, Discovery Call Prep, Proposal Writer, Account Plan. Build competitive battlecards, prepare structured discovery calls, write winning proposals, and create strategic account plans.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-sales",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-operations",
      "description": "Operations skills: Process Documentation, SOP Writer, Vendor Evaluation, Project Status Report. Document workflows, write audit-ready SOPs, evaluate vendors with weighted scorecards, and produce RAG status reports.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-operations",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-research",
      "description": "Research and healthcare skills: Clinical Case Summary, Research Protocol, Patient Communication, Literature Review. Write SBAR handovers, design research protocols, draft accessible patient communications, and structure literature reviews.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-research",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-cross",
      "description": "Cross-profession skills: Press Release, Grant Proposal, Executive Summary. Write journalist-ready press releases, structure grant applications aligned to funder priorities, and produce decision-ready executive summaries.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-cross",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    },
    {
      "name": "pm-figma",
      "description": "Figma skills for PMs and designers: Component Audit, Design Brief, Annotation Guide, Design Review, User Flow Planner, Variant Matrix, Spacing System, Prototype Plan, Design QA, PM Design Critique. Work smarter across the full Figma design lifecycle.",
      "version": "1.0.0",
      "category": "productivity",
      "source": "./plugins/pm-figma",
      "homepage": "https://github.com/mohitagw15856/pm-claude-skills"
    }
  ]
}
EOF

echo "✓ marketplace.json updated to v5.1.0 with 22 plugins (90 skills)"
echo ""
echo "Next:"
echo "  git add .claude-plugin/marketplace.json"
echo "  git commit -m 'chore: update marketplace.json to v5.1.0 — 22 plugins, 90 skills'"
echo "  git push origin main --force"
echo ""
echo "Then in Claude Code:"
echo "  /plugin marketplace remove mohitagw15856/pm-claude-skills"
echo "  /plugin marketplace add mohitagw15856/pm-claude-skills"
