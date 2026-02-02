# List available recipes
default:
    @just --list

# Compile resume to PDF in build directory (uses Docker if pdflatex not installed)
build:
    @./scripts/build.sh Saif_Hakeam_Resume.tex

# Open compiled PDF
open:
    @open build/Saif_Hakeam_Resume.pdf

# Clean build artifacts
clean:
    @rm -rf build/
