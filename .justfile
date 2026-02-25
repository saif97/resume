# List available recipes
default:
    @just --list

# Compile resume to PDF in build directory (uses Docker if pdflatex not installed)
build RESUME='Saif_Hakeam_Resume.tex':
    @./scripts/build.sh "{{RESUME}}"

# Analyze resume - full feedback loop (build → convert images → Gemini analysis)
analyze RESUME='Saif_Hakeam_Resume.tex':
    @./scripts/analyze_resume.sh "{{RESUME}}"

# Convert existing PDF to images (for visual analysis)
convert-images PDF='build/Saif_Hakeam_Resume.pdf':
    @./scripts/pdf_to_images.sh "{{PDF}}"

# Run visual analysis on existing images
analyze-visuals IMAGES_DIR='build/images':
    @./scripts/analyze_visuals.sh "{{IMAGES_DIR}}"

# Open compiled PDF
open:
    @open build/Saif_Hakeam_Resume.pdf

# Clean build artifacts
clean:
    @rm -rf build/
