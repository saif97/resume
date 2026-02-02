# LaTeX Resume Template with AI-Assisted Optimization

A clean, professional LaTeX resume template with built-in AI prompts for crafting impactful bullet points. Fork this repo, replace the content with your own experience, and use the reference docs to write resume bullets that get interviews.

## Prerequisites

- **[just](https://github.com/casey/just)** command runner
- **LaTeX distribution** (one of the following):
  - [MacTeX](https://www.tug.org/mactex/) (macOS, full distribution)
  - [BasicTeX](https://www.tug.org/mactex/morepackages.html) (macOS, minimal)
  - [TeX Live](https://www.tug.org/texlive/) (Linux/Windows)
  - **OR** [Docker](https://www.docker.com/) (automatic fallback if no local LaTeX)

### Installing just

```bash
# macOS
brew install just

# Linux
cargo install just  # or use your package manager

# Windows
choco install just
```

## Quick Start

1. **Clone/fork the repository**
   ```bash
   git clone https://github.com/yourusername/resume.git
   cd resume
   ```

2. **Rename the main file**
   ```bash
   mv Saif_Hakeam_Resume.tex Your_Name_Resume.tex
   ```

3. **Update the justfile** (`.justfile`)
   ```
   # Change the filename in the build command
   @./scripts/build.sh Your_Name_Resume.tex
   ```

4. **Edit your resume**
   ```bash
   # Open the .tex file in your editor
   vim Your_Name_Resume.tex
   ```

5. **Build and preview**
   ```bash
   just build   # Compile to PDF
   just open    # Open the PDF (macOS)
   ```

## Build Commands

```bash
just          # List available commands
just build    # Compile resume to PDF (outputs to build/)
just open     # Open the compiled PDF
just clean    # Remove build artifacts
```

The build script automatically falls back to Docker (`blang/latex:ubuntu`) if no local LaTeX installation is found.

## Project Structure

```
.
├── Your_Name_Resume.tex          # Main resume source (edit this)
├── work_experience_details.md    # Context file for AI assistance
├── references/
│   ├── recruiter_guidelines.md   # Resume best practices & XYZ formula
│   └── bullet_examples.md        # Before/after bullet point examples
├── scripts/
│   └── build.sh                  # Build script with Docker fallback
├── build/                        # Compiled PDF output (gitignored)
├── applications/                 # Job-specific tailored versions
└── CLAUDE.md                     # AI assistant instructions
```

## LaTeX Conventions

The template uses these custom commands and styles:

| Feature | Usage |
|---------|-------|
| Links | `\myhref{url}{text}` - Blue text with underline (Google Docs style) |
| Sections | `\section{Title}` - Bold title with thin horizontal rule |
| Job headers | `tabular*` for title/company/date alignment |
| Bullet spacing | Tight `itemize` (1pt itemsep) |
| Font | Lato sans-serif via `\usepackage[default]{lato}` |

## AI-Assisted Workflow

This template is optimized for use with Claude or other AI assistants:

### 1. Fill out your work experience context

Edit `work_experience_details.md` with raw details about your roles:
- What you built and why
- Metrics and scale (users, $, transactions)
- Technical challenges and solutions
- Business impact and outcomes

### 2. Use the reference docs

The `references/` folder contains:
- **XYZ Formula**: "Accomplished [X] as measured by [Y] by doing [Z]"
- **Strong action verbs**: Led, Architected, Reduced, Increased (avoid: "responsible for", "worked on")
- **Before/after examples**: See how vague bullets become interview-worthy

### 3. Ask for help crafting bullets

The AI can:
- Transform vague descriptions into quantified impact statements
- Extract metrics you might be underselling
- Tailor bullets for specific job postings

## Customizing the Template

### Margins and spacing

Adjust in the preamble:
```latex
\setlength{\oddsidemargin}{-0.5in}
\setlength{\textwidth}{7.0in}
\setlength{\topmargin}{-0.75in}
\setlength{\textheight}{10.7in}
```

### Link color

Change the blue link color:
```latex
\definecolor{docblue}{RGB}{17, 85, 204}  % Default Google Docs blue
```

### Font

Replace Lato with another font:
```latex
\usepackage[default]{lato}  % Change to: \usepackage{helvet}, etc.
```

## Troubleshooting

### "pdflatex not found" and Docker fails

Install a LaTeX distribution:
```bash
# macOS (minimal)
brew install --cask basictex
eval "$(/usr/libexec/path_helper)"  # Reload PATH

# Then install required packages
sudo tlmgr update --self
sudo tlmgr install lato ulem
```

### Missing packages

If compilation fails with "file not found" errors:
```bash
sudo tlmgr install <package-name>
```

Common packages needed: `lato`, `ulem`, `babel-english`

### Docker fallback

If you prefer Docker over local LaTeX:
```bash
# Pre-pull the image
docker pull blang/latex:ubuntu

# Build will automatically use Docker
just build
```

## License

MIT License - Feel free to use and modify for your own resume.
