# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LaTeX resume template with AI-assisted optimization. Fork this repo, replace content with your own experience, and use the reference docs to craft strong bullet points.

## Build Commands

```bash
just build    # Compile resume to PDF (local pdflatex or Docker fallback)
just open     # Open compiled PDF
just clean    # Clean build artifacts
```

## Key Files

- `Saif_Hakeam_Resume.tex` - Main resume source (rename to your own)
- `work_experience_details.md` - Add detailed context about your roles here for better bullet crafting
- `references/recruiter_guidelines.md` - Resume best practices and XYZ formula
- `references/bullet_examples.md` - Before/after bullet point examples

## LaTeX Conventions

- `\myhref{url}{text}` for blue underlined links (Google Docs style)
- Sans serif font (Lato via `\usepackage[default]{lato}`)
- Custom `\section{}` with thin horizontal rule
- `tabular*` for job title/date alignment
- Tight `itemize` spacing (1pt itemsep)

## Resume Optimization Guidelines

When editing resume content:

1. **XYZ Formula**: Accomplished [X] as measured by [Y] by doing [Z]
2. **Avoid weak verbs**: "responsible for", "worked on", "helped" → use "Led", "Architected", "Reduced", "Increased"
3. **Always include metrics**: scale (users, $), performance (latency, uptime), business impact (cost savings, revenue)
4. **Consult reference docs** in `references/` for examples and detailed guidance

## Workflow for AI-Assisted Resume Writing

1. Fill out `work_experience_details.md` with raw context about your roles (challenges, metrics, tech used)
2. Ask Claude to craft bullet points using the XYZ formula and reference docs
3. Edit `*.tex` file with the refined bullets
4. Run `just build` to compile and `just open` to preview

## Compilation

The build script (`scripts/compile_latex.py`) runs pdflatex twice to resolve references. It automatically falls back to Docker (`blang/latex:ubuntu`) if local pdflatex is unavailable.

Requires either:
- Local pdflatex (TeX Live, MacTeX, BasicTeX)
- Docker with `blang/latex:ubuntu` image (auto-fallback)
