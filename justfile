# Resume build tasks

# Start live preview server (auto-reloads on changes)
preview:
    @echo "🌐 Starting live preview server..."
    @echo "📝 Your resume will open at: http://localhost:8080"
    @echo "💡 Edit resume.html or styles.css - changes auto-refresh!"
    @echo "🛑 Press Ctrl+C to stop"
    npx live-server --port=8080 --wait=200 --open=resume.html

# Build PDF using Docker
build:
    @echo "🚀 Building resume PDF..."
    docker run --rm \
        -v "{{justfile_directory()}}:/workspace" \
        -w /workspace \
        zenika/alpine-chrome:latest \
        --no-sandbox \
        --disable-gpu \
        --headless \
        --print-to-pdf=resume.pdf \
        --print-to-pdf-no-header \
        file:///workspace/resume.html
    @echo "✅ Success! Resume saved as resume.pdf"
    @ls -lh resume.pdf | awk '{print "📄 File size: " $$5}'

# Clean generated files
clean:
    @echo "🧹 Cleaning generated files..."
    rm -f resume.pdf
    @echo "✅ Clean complete"

# Show available commands
help:
    @just --list
