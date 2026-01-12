#!/usr/bin/env python3
"""
Compile LaTeX resume to PDF using pdflatex.
Automatically falls back to Docker if local pdflatex is not available.
Runs multiple passes to resolve references and handles common LaTeX compilation issues.
"""

import sys
import subprocess
import os
import shutil
from pathlib import Path
from typing import Optional

def check_command_exists(command: str) -> bool:
    """Check if a command exists in PATH."""
    return shutil.which(command) is not None

def compile_with_docker(tex_file: Path, output_dir: Optional[Path] = None) -> bool:
    """
    Compile LaTeX file using Docker.

    Args:
        tex_file: Path to the .tex file
        output_dir: Optional output directory for the PDF

    Returns:
        True if compilation successful, False otherwise
    """
    print("🐳 Local pdflatex not found. Using Docker...")

    # Get absolute paths
    tex_abs = tex_file.absolute()
    work_dir = tex_abs.parent

    # Docker image to use (small, ~220MB)
    docker_image = "blang/latex:ctanbasic"

    # Check if Docker is available
    if not check_command_exists("docker"):
        print("❌ Error: Docker is not installed or not in PATH")
        print("   Please install Docker or a LaTeX distribution (e.g., MacTeX, BasicTeX)")
        return False

    print(f"   Using Docker image: {docker_image}")
    print(f"   This may take a moment if the image needs to be downloaded...")

    # Run pdflatex in Docker
    # We run it twice to resolve references
    for i in range(2):
        docker_cmd = [
            "docker", "run", "--rm",
            "-v", f"{work_dir}:/workspace",
            "-w", "/workspace",
            docker_image,
            "pdflatex", "-interaction=nonstopmode", tex_file.name
        ]

        try:
            result = subprocess.run(
                docker_cmd,
                capture_output=True,
                text=True,
                timeout=120  # 2 minute timeout
            )

            if result.returncode != 0:
                print(f"❌ Error during Docker compilation (pass {i+1}):")
                # Only show last 50 lines to avoid overwhelming output
                stderr_lines = result.stderr.split('\n')
                stdout_lines = result.stdout.split('\n')
                print('\n'.join(stderr_lines[-50:]))
                print('\n'.join(stdout_lines[-50:]))
                return False

        except subprocess.TimeoutExpired:
            print("❌ Error: Compilation timed out after 2 minutes")
            return False
        except Exception as e:
            print(f"❌ Error running Docker: {e}")
            return False

    # Check if PDF was created
    pdf_file = work_dir / f"{tex_file.stem}.pdf"
    if pdf_file.exists():
        print(f"✅ Successfully compiled using Docker: {pdf_file}")

        # Move to output_dir if specified
        if output_dir and output_dir != work_dir:
            output_dir.mkdir(parents=True, exist_ok=True)
            dest = output_dir / pdf_file.name
            shutil.move(str(pdf_file), str(dest))
            print(f"   Moved to: {dest}")

        return True
    else:
        print("❌ Error: PDF file was not created")
        return False

def compile_with_pdflatex(tex_file: Path, output_dir: Optional[Path] = None) -> bool:
    """
    Compile LaTeX file using local pdflatex.

    Args:
        tex_file: Path to the .tex file
        output_dir: Optional output directory for the PDF

    Returns:
        True if compilation successful, False otherwise
    """
    print("📄 Compiling with local pdflatex...")

    # Set output directory
    if output_dir:
        output_path = output_dir
        output_path.mkdir(parents=True, exist_ok=True)
    else:
        output_path = tex_file.parent

    # Change to the directory containing the tex file
    original_dir = os.getcwd()
    os.chdir(tex_file.parent)

    try:
        # Run pdflatex twice (common practice for LaTeX to resolve references)
        for i in range(2):
            result = subprocess.run(
                ['pdflatex', '-interaction=nonstopmode', '-output-directory', str(output_path), tex_file.name],
                capture_output=True,
                text=True,
                timeout=120
            )

            if result.returncode != 0:
                print(f"❌ Error during compilation (pass {i+1}):")
                print(result.stdout)
                print(result.stderr)
                return False

        pdf_file = output_path / f"{tex_file.stem}.pdf"
        if pdf_file.exists():
            print(f"✅ Successfully compiled: {pdf_file}")
            return True
        else:
            print("❌ Error: PDF file was not created")
            return False

    except subprocess.TimeoutExpired:
        print("❌ Error: Compilation timed out after 2 minutes")
        return False
    except Exception as e:
        print(f"❌ Error during compilation: {e}")
        return False
    finally:
        os.chdir(original_dir)

def compile_latex(tex_file: str, output_dir: Optional[str] = None) -> bool:
    """
    Compile a LaTeX file to PDF.
    Automatically detects and uses either local pdflatex or Docker.

    Args:
        tex_file: Path to the .tex file
        output_dir: Optional output directory for the PDF (defaults to same dir as tex file)

    Returns:
        True if compilation successful, False otherwise
    """
    tex_path = Path(tex_file)
    if not tex_path.exists():
        print(f"❌ Error: File not found: {tex_file}")
        return False

    if not tex_path.suffix == '.tex':
        print(f"❌ Error: Not a .tex file: {tex_file}")
        return False

    output_path = Path(output_dir) if output_dir else None

    # Try local pdflatex first, fall back to Docker
    if check_command_exists("pdflatex"):
        return compile_with_pdflatex(tex_path, output_path)
    else:
        return compile_with_docker(tex_path, output_path)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python compile_latex.py <file.tex> [output_dir]")
        print("\nThis script will:")
        print("  1. Try to use local pdflatex if available")
        print("  2. Fall back to Docker (blang/latex:ctanbasic) if pdflatex not found")
        sys.exit(1)

    tex_file = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else None

    success = compile_latex(tex_file, output_dir)
    sys.exit(0 if success else 1)
