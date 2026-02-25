#!/usr/bin/env bash
set -e

# Resume Visual Analysis Script using Gemini
# Usage: ./scripts/analyze_visuals.sh <path_to_images_directory>

IMAGES_DIR="$1"

if [ -z "$IMAGES_DIR" ]; then
    echo "Error: No images directory provided"
    echo "Usage: $0 <path_to_images_directory>"
    exit 1
fi

if [ ! -d "$IMAGES_DIR" ]; then
    echo "Error: Directory not found: $IMAGES_DIR"
    exit 1
fi

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "  RESUME VISUAL ANALYSIS"
echo "═════════════════════════════════════════════════════════════"
echo "Analyzing resume images in: $IMAGES_DIR"
echo "---"

gemini -p "You are a Staff Technical Hiring Manager with 15+ years experience reviewing 10,000+ resumes for top-tier companies (FAANG, high-growth startups, enterprise).

Analyze all resume images in the included directory. For each page, check:

1. **⚠️ CRITICAL: Text cutoff at page edges** - Is any content cut off at the top, bottom, left, or right margins? Look for text that appears partially truncated or too close to edges.
2. **Text alignment**: Are headers, section titles, dates, and bullet points properly aligned?
3. **Spacing inconsistencies**: Are there uneven gaps between sections, bullets, or lines?
4. **Content layout**: Is any text broken awkwardly across pages or running into margins?
5. **Professional polish**: Are fonts consistent? Are margins even? Any formatting oddities?

For each issue found:
- Specify the page number
- Describe the location (e.g., 'bottom of page 1', 'right margin page 2')
- Rate severity: CRITICAL (must fix), WARNING (should fix), INFO (nice to have)
- Be specific about what's wrong and how it looks unprofessional

Output your findings in a structured markdown table format:
| Page | Location | Issue Description | Severity |

After the table, provide 3-5 strategic recommendations for improving the resume.

⚠️ IMPORTANT: If ANY text is cut off at page edges, this is CRITICAL and must be reported immediately." --include-directories="$IMAGES_DIR"

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "  Analysis complete"
echo "═════════════════════════════════════════════════════════════"
