#!/bin/bash
# Run from your repo root: cd pm-claude-skills && bash add-plugin-json.sh
# Writes plugin.json into every bundle's .claude-plugin/ folder, commits, and pushes.

echo "=== Writing plugin.json for all 8 bundles ==="

# ─────────────────────────────────────────
# BUNDLE 1: pm-essentials
# ─────────────────────────────────────────
cat > plugins/pm-essentials/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-essentials",
  "version": "3.0.0",
  "description": "Core PM skills: PRD Template, Meeting Notes, Stakeholder Update, User Research Synthesis, and Competitive Analysis. The 5 skills every PM needs first.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "prd", "meeting-notes", "stakeholder", "user-research", "competitive-analysis"]
}
EOF
echo "✓ pm-essentials/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 2: pm-discovery
# ─────────────────────────────────────────
cat > plugins/pm-discovery/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-discovery",
  "version": "3.0.0",
  "description": "Discovery & research skills: Discovery Interview Guide, Job Story Mapper, User Interview Synthesis, Assumption Mapper. Structure user research from screener to synthesis.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "user-research", "discovery", "jtbd", "interviews", "assumption-mapping"]
}
EOF
echo "✓ pm-discovery/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 3: pm-planning
# ─────────────────────────────────────────
cat > plugins/pm-planning/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-planning",
  "version": "3.0.0",
  "description": "Planning & strategy skills: OKR Builder, Feature Prioritisation (RICE/MoSCoW/Kano/ICE), Roadmap Presentation, Pricing Strategy, RICE + Impact Matrix, Roadmap Narrative.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "okr", "prioritisation", "roadmap", "pricing", "rice", "moscow", "kano"]
}
EOF
echo "✓ pm-planning/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 4: pm-delivery
# ─────────────────────────────────────────
cat > plugins/pm-delivery/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-delivery",
  "version": "3.0.0",
  "description": "Sprint & delivery skills: Sprint Planning, Technical Spec Template, A/B Test Planner, Go-to-Market Planner, Product Launch Checklist, Sprint Brief, Retro Analysis.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "sprint", "agile", "ab-testing", "go-to-market", "launch", "technical-spec"]
}
EOF
echo "✓ pm-delivery/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 5: pm-analytics
# ─────────────────────────────────────────
cat > plugins/pm-analytics/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-analytics",
  "version": "3.0.0",
  "description": "Data & metrics skills: Data Analysis Standard, Retention Analysis, Product Health Analysis. Structure metric deep-dives, funnel analysis, cohort studies and churn investigations.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "analytics", "retention", "metrics", "funnel", "cohort", "churn"]
}
EOF
echo "✓ pm-analytics/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 6: pm-strategy
# ─────────────────────────────────────────
cat > plugins/pm-strategy/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-strategy",
  "version": "3.0.0",
  "description": "Strategy & stakeholder skills: Competitor Signal Tracker, Competitive Intelligence Monitor, Stakeholder Influence Mapper, Strategic Narrative Generator, Executive Update, Ambiguity Resolver.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "strategy", "competitive-intelligence", "stakeholder", "executive", "narrative"]
}
EOF
echo "✓ pm-strategy/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 7: pm-advanced
# ─────────────────────────────────────────
cat > plugins/pm-advanced/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-advanced",
  "version": "3.0.0",
  "description": "Advanced PM skills: AI Product Canvas, Multi-Source Signal Synthesiser, Experiment Designer, Design Handoff Brief. For senior PMs working on complex or AI-powered products.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "ai-product", "experiment-design", "design-handoff", "signal-synthesis"]
}
EOF
echo "✓ pm-advanced/plugin.json written"

# ─────────────────────────────────────────
# BUNDLE 8: pm-rituals
# ─────────────────────────────────────────
cat > plugins/pm-rituals/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-rituals",
  "version": "3.0.0",
  "description": "PM Weekly Review: a 20-minute structured ritual covering metrics movement, shipping progress, customer insights, and next week's top 3 priorities in a shareable update.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["product-management", "weekly-review", "productivity", "rituals", "planning"]
}
EOF
echo "✓ pm-rituals/plugin.json written"

# ─────────────────────────────────────────
# COMMIT AND PUSH
# ─────────────────────────────────────────
echo ""
echo "=== All 8 plugin.json files written ==="
echo ""
echo "=== Committing and pushing ==="

git add plugins/pm-essentials/.claude-plugin/plugin.json
git add plugins/pm-discovery/.claude-plugin/plugin.json
git add plugins/pm-planning/.claude-plugin/plugin.json
git add plugins/pm-delivery/.claude-plugin/plugin.json
git add plugins/pm-analytics/.claude-plugin/plugin.json
git add plugins/pm-strategy/.claude-plugin/plugin.json
git add plugins/pm-advanced/.claude-plugin/plugin.json
git add plugins/pm-rituals/.claude-plugin/plugin.json

git commit -m "add plugin.json manifests for all 8 PM skill bundles"
git push

echo ""
echo "=== Pushed! Now re-adding the marketplace in Claude Code ==="
echo ""
echo "Run these commands inside Claude Code:"
echo ""
echo "  /plugin marketplace remove mohitagw15856/pm-claude-skills"
echo "  /plugin marketplace add mohitagw15856/pm-claude-skills"
echo ""
echo "Then install any bundle you want:"
echo "  /plugin install pm-essentials@pm-claude-skills"
echo "  /plugin install pm-discovery@pm-claude-skills"
echo "  /plugin install pm-planning@pm-claude-skills"
echo "  /plugin install pm-delivery@pm-claude-skills"
echo "  /plugin install pm-analytics@pm-claude-skills"
echo "  /plugin install pm-strategy@pm-claude-skills"
echo "  /plugin install pm-advanced@pm-claude-skills"
echo "  /plugin install pm-rituals@pm-claude-skills"
echo ""
echo "=== Done ==="
