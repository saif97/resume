#!/usr/bin/env bash
set -e

TEX_FILE="${1:-Saif_Hakeam_Resume.tex}"
# Default output directory to the directory containing the tex file, or build/ if not specified
OUT_DIR="${2:-$(dirname "$TEX_FILE")}"

if command -v pdflatex &> /dev/null; then
    pdflatex -output-directory="$OUT_DIR" "$TEX_FILE"
    pdflatex -output-directory="$OUT_DIR" "$TEX_FILE"
else
    echo "pdflatex not found, using Docker..."
    docker run --rm -v "$(pwd):/work" -w /work blang/latex:ubuntu \
        sh -c "pdflatex -output-directory=$OUT_DIR $TEX_FILE && pdflatex -output-directory=$OUT_DIR $TEX_FILE"
fi
