#!/usr/bin/env bash
set -e

# Convert PDF to images for visual analysis
# Usage: ./scripts/pdf_to_images.sh <path_to_pdf>

PDF_PATH="$1"

if [ -z "$PDF_PATH" ]; then
    echo "Error: No PDF path provided"
    echo "Usage: $0 <path_to_pdf>"
    exit 1
fi

if [ ! -f "$PDF_PATH" ]; then
    echo "Error: PDF not found: $PDF_PATH"
    exit 1
fi

# Determine output directory (images/ next to PDF)
PDF_DIR="$(dirname "$PDF_PATH")"
OUTPUT_DIR="$PDF_DIR/images"

# Create output directory (clear if exists)
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Convert PDF to PNG images using Docker
echo "Converting PDF to images..."
docker run --rm \
    -v "$(pwd):/work" \
    -w /work \
    justsocial/just-pdftoppm:latest \
    pdftoppm -png -r 150 "$PDF_PATH" "$OUTPUT_DIR/page"

# Count generated images
IMAGE_COUNT=$(ls -1 "$OUTPUT_DIR"/page-*.png 2>/dev/null | wc -l | tr -d ' ')

echo "✓ Generated $IMAGE_COUNT page images in: $OUTPUT_DIR/"
ls -lh "$OUTPUT_DIR"/page-*.png
