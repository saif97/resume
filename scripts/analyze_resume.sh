#!/usr/bin/env bash
set -e

# Resume Feedback Loop - Build, Convert, and Analyze
# Usage: ./scripts/analyze_resume.sh <path_to_tex_file>

TEX_FILE="$1"

if [ -z "$TEX_FILE" ]; then
    echo "Error: No .tex file provided"
    echo "Usage: $0 <path_to_tex_file>"
    exit 1
fi

if [ ! -f "$TEX_FILE" ]; then
    echo "Error: TeX file not found: $TEX_FILE"
    exit 1
fi

# Get PDF path (same name as .tex, in same directory)
TEX_DIR="$(dirname "$TEX_FILE")"
TEX_NAME="$(basename "$TEX_FILE" .tex)"
PDF_PATH="$TEX_DIR/${TEX_NAME}.pdf"

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "  RESUME FEEDBACK LOOP"
echo "═════════════════════════════════════════════════════════════"
echo "TeX file: $TEX_FILE"
echo ""

# Step 1: Build PDF
echo "[1/3] Building PDF..."
./scripts/build.sh "$TEX_FILE"

if [ ! -f "$PDF_PATH" ]; then
    echo "Error: PDF build failed"
    exit 1
fi

echo "✓ PDF generated: $PDF_PATH"
echo ""

# Step 2: Convert PDF to images
echo "[2/3] Converting PDF to images..."
./scripts/pdf_to_images.sh "$PDF_PATH"
echo ""

# Step 3: Analyze visuals
echo "[3/3] Running visual analysis..."
IMAGES_DIR="$TEX_DIR/images"
./scripts/analyze_visuals.sh "$IMAGES_DIR"

echo ""
echo "═════════════════════════════════════════════════════════════"
echo "  Feedback loop complete!"
echo "═════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Review findings above"
echo "  2. Edit $TEX_FILE to address issues"
echo "  3. Run again: ./scripts/analyze_resume.sh $TEX_FILE"
echo ""
