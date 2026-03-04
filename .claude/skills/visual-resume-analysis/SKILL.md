# Skill: Visual Resume Analysis

Analyze resume PDFs for visual issues by building from LaTeX, converting to images, and performing visual inspection.

## When to Use

Use this skill when you need to check a resume for:
- Text cutoff or overflow issues
- Alignment problems
- Spacing inconsistencies
- Page break issues
- Font rendering problems
- Overall visual polish

## Tools Available

- **Bash**: Run shell commands and scripts
- **Read**: View image files
- **Agent**: Spawn sub-agents if needed (not typically needed)

## Input

- Path to LaTeX file (e.g., `Saif_Hakeam_Resume.tex`)

## Output

Structured analysis report with:
- Summary of issues found
- Detailed findings table
- Severity ratings (Critical, Warning, Info)
- Recommendations for fixes

## Workflow

### Step 1: Build the PDF

Run the build script to compile LaTeX to PDF:

```bash
./scripts/build.sh <path_to_tex_file>
```

The PDF will be created in the same directory as the `.tex` file.

### Step 2: Convert PDF to Images

Convert the generated PDF to PNG images:

```bash
./scripts/pdf_to_images.sh <path_to_pdf>
```

This creates an `images/` directory next to the PDF with page images named:
- `page-1.png`, `page-2.png`, etc.

### Step 3: Read All Page Images

Use the Read tool to view each generated page image.

### Step 4: Analyze Visual Issues

For each page, check for:

| Check | What to Look For |
|-------|------------------|
| **Text Cutoff** | Text extending beyond margins, clipped at page edges |
| **Overflow** | Content bleeding into footer/header areas |
| **Alignment** | Misaligned columns, uneven indentation, ragged edges |
| **Spacing** | Inconsistent line spacing, paragraph gaps, section breaks |
| **Page Breaks** | Awkward breaks mid-section, orphaned content |
| **Font Issues** | Inconsistent font sizes, rendering artifacts, bold/italic problems |
| **Visual Balance** | White space distribution, density variations |
| **Links** | Visible URLs should use proper link styling |
| **Lists** | Bullet alignment, indentation consistency |

### Step 5: Return Structured Feedback

Output format:

```markdown
## Visual Analysis Summary

**File:** `<tex_filename>`
**Pages:** <N>
**Overall Status:** ✅ Clean / ⚠️ Issues Found / ❌ Critical Issues

## Findings

| Page | Issue | Severity | Description | Recommendation |
|------|-------|----------|-------------|----------------|
| 1 | Text overflow in header | Critical | Email address clipped at right margin | Shorten email or adjust tabular spacing |
| 1 | Uneven bullet spacing | Warning | Inconsistent 3pt vs 6pt gaps between items | Standardize on 2-3pt itemsep |

## Detailed Observations

### Page 1
- <Observation 1>
- <Observation 2>

### Page 2 (if applicable)
- <Observation 1>

## Recommendations

1. **Priority: Critical** - <action item>
2. **Priority: Warning** - <action item>
3. **Priority: Info** - <suggestion>
```

## Severity Guidelines

- **Critical**: Would cause rejection or unreadability (text cutoff, broken layout)
- **Warning**: Unprofessional appearance, may affect first impression (spacing issues, minor alignment)
- **Info**: Suggestions for improvement (color contrast, whitespace optimization)

## Example Usage

```
User: "Check my resume for visual issues"

1. Identify the .tex file (e.g., Saif_Hakeam_Resume.tex)
2. Run: ./scripts/build.sh Saif_Hakeam_Resume.tex
3. Run: ./scripts/pdf_to_images.sh Saif_Hakeam_Resume.pdf
4. Read: Saif_Hakeam_Resume/images/page-1.png
5. Analyze and return structured report
```

## Notes

- The build script runs pdflatex twice to resolve references
- Image conversion uses Docker with `justsocial/just-pdftoppm` image
- Resolution is 150 DPI (sufficient for visual analysis)
- If build fails, check for LaTeX syntax errors in the .tex file
