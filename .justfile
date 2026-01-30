# List available recipes
default:
    @just --list

# Compile resume to PDF in build directory
build:
    @echo "📄 Compiling resume..."
    @python scripts/compile_latex.py Saif_Hakeam_Resume.tex build/

# Open compiled PDF
open:
    @open build/Saif_Hakeam_Resume.pdf

# Clean build artifacts
clean:
    @echo "🧹 Cleaning build directory..."
    @rm -rf build/
    @echo "✅ Build directory cleaned"
