# LaTeX Resume Template

A LaTeX resume template designed for use with AI coding agents like [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## How It Works

1. Create your resume file (e.g., `Your_Name_Resume.tex`)
2. Open the project with Claude Code in **plan mode**
3. The agent will grill you with questions about your work experience to extract metrics, impact, and context
4. It accumulates your answers in `work_experience_details.md` and crafts strong bullet points

## Build

```bash
./scripts/build.sh Your_Name_Resume.tex
```

Uses local `pdflatex` if available, otherwise falls back to Docker.

## Example

```latex
\section{Professional Experience}

\noindent
\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}r}
  \textbf{Software Engineer} & Jan 2022 - Present \\
  \textit{\myhref{https://company.com}{Company Name}} & \textit{City, Country} \\
\end{tabular*}

\begin{itemize}
  \setlength{\itemsep}{1pt}
  \item Led development of X, reducing Y by Z\% and saving \$N annually.
  \item Architected CI/CD pipeline, cutting release cycles from 1 week to 1 day.
\end{itemize}
```

## References

- `references/recruiter_guidelines.md` - XYZ formula and best practices
- `references/bullet_examples.md` - Before/after examples

## Requirements

`pdflatex` ([MacTeX](https://www.tug.org/mactex/), [TeX Live](https://www.tug.org/texlive/)) or [Docker](https://www.docker.com/)
