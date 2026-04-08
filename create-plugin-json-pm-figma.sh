#!/bin/bash

# =============================================================================
# create-plugin-json-pm-figma.sh
# Run from the ROOT of your pm-claude-skills repo.
# Creates the .claude-plugin/plugin.json for the pm-figma bundle.
# =============================================================================

set -e

if [ ! -d "$(pwd)/plugins" ]; then
  echo "ERROR: Run from the root of pm-claude-skills"
  exit 1
fi

mkdir -p plugins/pm-figma/.claude-plugin

cat > plugins/pm-figma/.claude-plugin/plugin.json << 'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "pm-figma",
  "version": "1.0.0",
  "description": "Figma skills for product managers and designers: Component Audit, Design Brief, Annotation Guide, Design Review, User Flow Planner, Variant Matrix, Spacing System, Prototype Plan, Design QA, PM Design Critique. Work smarter in Figma across the full design lifecycle.",
  "author": {
    "name": "Mohit Aggarwal",
    "email": "mohit15856@gmail.com"
  },
  "homepage": "https://github.com/mohitagw15856/pm-claude-skills",
  "license": "MIT",
  "keywords": ["figma", "design", "product-management", "design-system", "components", "prototype", "handoff", "ux"]
}
EOF

echo "✓ plugins/pm-figma/.claude-plugin/plugin.json created"
echo ""
echo "Next: run setup-pm-figma.sh then update-marketplace.sh"
