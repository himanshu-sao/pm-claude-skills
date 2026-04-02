#!/bin/bash

# =============================================================================
# create-plugin-jsons.sh
# Run this from the ROOT of your pm-claude-skills repo.
# Creates .claude-plugin/plugin.json inside each of the 6 new plugin folders.
# Your skills/ subfolders are already in place — this just adds the missing
# plugin.json files.
# =============================================================================

set -e

REPO_ROOT="$(pwd)"

echo "================================================"
echo " pm-claude-skills — Creating plugin.json files"
echo " Running from: $REPO_ROOT"
echo "================================================"
echo ""

# Sanity check — make sure we're in the right place
if [ ! -d "$REPO_ROOT/pm-gtm" ] || [ ! -d "$REPO_ROOT/pm-engineering" ]; then
  echo "ERROR: Cannot find pm-gtm or pm-engineering folders."
  echo "Make sure you are running this from the ROOT of your pm-claude-skills repo."
  echo "Example: cd ~/pm-claude-skills && bash create-plugin-jsons.sh"
  exit 1
fi

# ---------------------------------------------------------
# BUNDLE 1: pm-gtm
# ---------------------------------------------------------
echo "Creating pm-gtm/.claude-plugin/plugin.json..."
mkdir -p pm-gtm/.claude-plugin
cat > pm-gtm/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-gtm",
  "version": "1.0.0",
  "description": "Marketing & GTM skills: Go-To-Market Planner, Content Calendar, Competitor Teardown, Email Campaign. Build positioning statements, messaging pillars, feature lists, use cases, and launch campaigns.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "marketing", "gtm", "positioning", "content-calendar", "competitor-analysis", "email-campaign"]
}
EOF
echo "  ✓ pm-gtm/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# BUNDLE 2: pm-engineering
# ---------------------------------------------------------
echo "Creating pm-engineering/.claude-plugin/plugin.json..."
mkdir -p pm-engineering/.claude-plugin
cat > pm-engineering/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-engineering",
  "version": "1.0.0",
  "description": "Engineering & tech skills: Code Review Checklist, Incident Postmortem, API Docs Writer, Architecture Decision Record. Structured outputs for engineering teams and technical PMs.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "engineering", "code-review", "incident-postmortem", "api-documentation", "adr", "architecture"]
}
EOF
echo "  ✓ pm-engineering/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# BUNDLE 3: pm-data
# ---------------------------------------------------------
echo "Creating pm-data/.claude-plugin/plugin.json..."
mkdir -p pm-data/.claude-plugin
cat > pm-data/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-data",
  "version": "1.0.0",
  "description": "Data & analytics skills: Metrics Framework, SQL Query Explainer, Dashboard Brief. Build North Star metric trees, explain and optimise SQL, and spec dashboards from business questions.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "data", "analytics", "metrics", "north-star", "sql", "dashboard", "kpi"]
}
EOF
echo "  ✓ pm-data/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# BUNDLE 4: pm-people
# ---------------------------------------------------------
echo "Creating pm-people/.claude-plugin/plugin.json..."
mkdir -p pm-people/.claude-plugin
cat > pm-people/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-people",
  "version": "1.0.0",
  "description": "Leadership & people skills: Performance Review, Hiring Rubric, Team Offsite Planner. Write structured reviews, build interview scorecards, and plan offsites from goals to minute-by-minute agenda.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "leadership", "management", "performance-review", "hiring", "interview", "offsite", "people"]
}
EOF
echo "  ✓ pm-people/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# BUNDLE 5: pm-design
# ---------------------------------------------------------
echo "Creating pm-design/.claude-plugin/plugin.json..."
mkdir -p pm-design/.claude-plugin
cat > pm-design/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-design",
  "version": "1.0.0",
  "description": "Design & UX skills: UX Research Plan, Design Critique, Accessibility Audit. Create research plans with discussion guides, critique designs using JTBD and Gestalt principles, and audit for WCAG 2.2 compliance.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "design", "ux", "user-research", "accessibility", "wcag", "usability", "design-critique"]
}
EOF
echo "  ✓ pm-design/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# BUNDLE 6: pm-business
# ---------------------------------------------------------
echo "Creating pm-business/.claude-plugin/plugin.json..."
mkdir -p pm-business/.claude-plugin
cat > pm-business/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-business",
  "version": "1.0.0",
  "description": "Business & strategy skills: Investor Update, Board Deck Narrative, Job Application. Write investor updates investors actually read, structure board presentations, and tailor CVs and cover letters with ATS optimisation.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "business", "strategy", "investor-update", "board-deck", "startup", "career", "job-application"]
}
EOF
echo "  ✓ pm-business/.claude-plugin/plugin.json created"

# ---------------------------------------------------------
# DONE
# ---------------------------------------------------------
echo ""
echo "================================================"
echo " All 6 plugin.json files created successfully!"
echo ""
echo "  pm-gtm/.claude-plugin/plugin.json"
echo "  pm-engineering/.claude-plugin/plugin.json"
echo "  pm-data/.claude-plugin/plugin.json"
echo "  pm-people/.claude-plugin/plugin.json"
echo "  pm-design/.claude-plugin/plugin.json"
echo "  pm-business/.claude-plugin/plugin.json"
echo ""
echo " Next steps:"
echo "  1. bash add-plugin-json.sh   (update marketplace.json)"
echo "  2. git add ."
echo "  3. git commit -m 'feat: add 6 new plugin bundles (pm-gtm, pm-engineering, pm-data, pm-people, pm-design, pm-business)'"
echo "  4. git push origin main"
echo "================================================"
