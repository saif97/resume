#!/usr/bin/env bash
set -e

TEX_FILE="${1:-Saif_Hakeam_Resume.tex}"
OUT_DIR="${2:-build}"

mkdir -p "$OUT_DIR"

if command -v pdflatex &> /dev/null; then
    pdflatex -output-directory="$OUT_DIR" "$TEX_FILE"
    pdflatex -output-directory="$OUT_DIR" "$TEX_FILE"
else
    echo "pdflatex not found, using Docker..."
    docker run --rm -v "$(pwd):/work" -w /work blang/latex:ubuntu \
        sh -c "pdflatex -output-directory=$OUT_DIR $TEX_FILE && pdflatex -output-directory=$OUT_DIR $TEX_FILE"
fi
