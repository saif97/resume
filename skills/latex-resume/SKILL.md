# Skill: LaTeX Resume

Create and maintain professional resumes using LaTeX with consistent formatting and best practices.

## When to Use

Use this skill when:
- Writing or editing LaTeX resume content
- Adding new sections or bullet points
- Fixing compilation errors
- Adjusting formatting, spacing, or layout
- Creating a new resume from the template

## Tools Available

- **Read**: View .tex files and reference docs
- **Edit**: Modify LaTeX source
- **Bash**: Run build commands, check output

## Project Conventions

### File Structure

```
Saif_Hakeam_Resume.tex    # Main resume source
work_experience_details.md # Raw context for bullet crafting
references/
  recruiter_guidelines.md  # Resume best practices
  bullet_examples.md       # Before/after examples
scripts/
  build.sh                 # Compile LaTeX to PDF
  pdf_to_images.sh         # Convert PDF for visual analysis
```

### LaTeX Conventions

| Element | Implementation |
|---------|---------------|
| **Links** | `\myhref{url}{text}` - blue underlined (Google Docs style) |
| **Font** | Sans serif via `\usepackage[default]{lato}` |
| **Sections** | Custom `\section{}` with thin horizontal rule |
| **Job headers** | `tabular*` for title/date left/right alignment |
| **Lists** | Tight `itemize` with 1pt `itemsep` |
| **Margins** | 0.5in all sides |
| **Page size** | US Letter (8.5x11in) |

### Common Commands

```bash
# Build PDF
just build
./scripts/build.sh Saif_Hakeam_Resume.tex

# View PDF
just open

# Clean artifacts
just clean

# Visual analysis
./scripts/pdf_to_images.sh Saif_Hakeam_Resume.pdf
```

## Resume Optimization Guidelines

### XYZ Formula

Every bullet should follow: **Accomplished [X] as measured by [Y] by doing [Z]**

| Weak | Strong |
|------|--------|
| "Worked on API optimization" | "Reduced API latency by 40% (400ms → 240ms) by implementing Redis caching" |
| "Responsible for team productivity" | "Increased team velocity 35% by introducing async standups and automated CI checks" |
| "Built a feature" | "Shipped MFA feature serving 1.6M+ users, reducing account takeovers by 60%" |

### Strong Verbs

Use: Led, Architected, Built, Shipped, Reduced, Increased, Designed, Implemented, Optimized

Avoid: "responsible for", "worked on", "helped with", "assisted in", "participated in"

### Metrics to Include

- **Scale**: users, transactions, $ volume, data volume
- **Performance**: latency, throughput, uptime, error rates
- **Business**: cost savings, revenue impact, time saved
- **Engineering**: build times, deployment frequency, bug reduction

## Common Patterns

### Job Entry Structure

```latex
\textbf{\myhref{https://company.com}{Company Name}} \hfill Location \\
\textit{Job Title} \hfill \textit{Month Year -- Month Year} \\[-0.4em]
\begin{itemize}[itemsep=1pt]
    \item \textbf{Accomplished X}, as measured by \textbf{Y}, by doing Z
    \item Second bullet with \textbf{bold metrics} for impact
\end{itemize}
\vspace{5pt}
```

### Skills Section

```latex
\section{Technical Skills}
\textbf{Category:} Skill 1, Skill 2, Skill 3 \\[2pt]
\textbf{Another:} Item 1, Item 2
```

### Education Entry

```latex
\textbf{Institution} \hfill \textit{Dates} \\
Degree or Certification \hfill \myhref{url}{Credential Link}
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Text overflow | Reduce content or adjust spacing (`\vspace{-2pt}`) |
| Bad page break | Add `\pagebreak[0]` or adjust section order |
| Font warning | Ignore minor warnings; for bullets, check `\textbullet` definition |
| Link not clickable | Ensure `\usepackage{hyperref}` and use `\myhref` |
| Bullet spacing too loose | Use `itemsep=1pt` in itemize options |

## Compilation

The build script runs `pdflatex` twice to resolve references. It auto-falls back to Docker if local pdflatex unavailable.

Requirements:
- Local: TeX Live, MacTeX, or BasicTeX
- Docker: `blang/latex:ubuntu` image

## Workflow

1. **Gather context** → Write in `work_experience_details.md`
2. **Craft bullets** → Apply XYZ formula, add metrics
3. **Edit .tex** → Follow conventions above
4. **Build & verify** → `just build && just open`
5. **Visual check** → Use `visual-resume-analysis` skill if needed
