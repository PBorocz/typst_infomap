"""Test Script."""
#!/usr/bin/env python3
#
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pytest==8.4.1",
# ]
# ///

import pytest
import subprocess
import sys
import os
import shutil
from pathlib import Path


def load_test_fragments(file_path: Path) -> list[tuple[str, str]]:
    """Load test fragments from a file, splitting on '--- <test name>' separator.

    Returns:
        List of tuples: (test_name, content)
    """
    if not file_path.exists():
        return []

    result = []
    current_test_name = None
    current_content_lines = []

    with open(file_path, "r") as f:
        for line in f:
            line = line.rstrip("\n")

            # Skip Typst comment lines
            if line.strip().startswith("//"):
                continue

            if line.startswith("--- "):
                # Save previous test if we have one
                if current_test_name is not None:
                    content = "\n".join(current_content_lines).strip()
                    if content:  # Only add if there's actual content
                        result.append((current_test_name, content))

                # Start new test
                current_test_name = line[4:].strip()  # Remove "--- " prefix
                current_content_lines = []
            else:
                # Accumulate content lines
                if current_test_name is not None:
                    current_content_lines.append(line)

    # Don't forget the last test
    if current_test_name is not None:
        content = "\n".join(current_content_lines).strip()
        if content:
            result.append((current_test_name, content))

    return result


# def load_test_fragments(file_path: Path) -> list[tuple[str, str]]:
#     """Load test fragments from a file, splitting on '--- <test name>' separator.

#     Returns:
#         List of tuples: (test_name, content)
#     """
#     if not file_path.exists():
#         return []

#     content = file_path.read_text()
#     fragments = content.split("\n---")

#     result = []
#     for fragment in fragments:
#         breakpoint()

#         fragment = fragment.strip()
#         if not fragment:
#             continue
#         lines = fragment.split("\n", 1)
#         if len(lines) == 2:
#             test_name = lines[0].strip()
#             test_content = lines[1].strip()
#             result.append((test_name, test_content))
#     return result


class TestTypstInfoMapping:
    """Test suite for Typst 'Information Mapping' library functions."""

    @pytest.fixture
    def infomap_path(self):
        """Path to the infomap.typ file with existence validation."""
        infomap_file = Path("infomap.typ")
        if not infomap_file.exists():
            pytest.skip(f"infomap.typ not found at {infomap_file}")
        return infomap_file

    def run_typst_test(self, typst_content: str, infomap_path: Path) -> tuple[int, str, str]:
        """Run a typst test using the given content.

        Returns:
            tuple: (return_code, stdout, stderr)
        """
        # Create a test/temporary subdirectory UNDER our current one if it's not there
        current_dir = Path.cwd()
        temp_dir = current_dir / f"temp_typst_test_{os.getpid()}_{id(self)}"
        temp_dir.mkdir(exist_ok=True)

        # Write the test content to the temp_file
        temp_file = temp_dir / "test.typ"
        with open(temp_file, "w") as f:
            f.write(typst_content)
        temp_output = temp_dir / "test.pdf"

        try:
            # Copy infomap.typ to temp directory
            shutil.copy2(infomap_path, temp_dir / "infomap.typ")

            # Run typst compile on the temporary file
            result = subprocess.run(
                ["typst", "compile", temp_file, temp_output],
                capture_output=True,
                text=True,
                timeout=30,
                cwd=str(temp_dir),
            )
            return result.returncode, result.stdout, result.stderr
        except subprocess.TimeoutExpired:
            return -1, "", "Timeout expired"
        finally:
            try:
                shutil.rmtree(temp_dir)
            except (FileNotFoundError, PermissionError):
                pass

    #
    # We get by with *TWO* core test methods:
    # 1 - Test for *valid* typst content.
    # 2 - Test for *invalid* typst content.
    #
    # Each test is parametrised to read from a respective typst file
    # with a special delimiter separating (and naming) the respective
    # test.
    #
    # See tests/content-valid.typ and tests/content-errors.typ for
    # more information.
    #
    @pytest.mark.parametrize(
        "test_name,content",
        load_test_fragments(Path("tests/content-valid.typ")),
        ids=lambda x: x[0] if isinstance(x, tuple) else str(x),
    )
    def test_valid_content(self, test_name, content, infomap_path):
        """Test content that should compile successfully."""
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success for '{test_name}' but got error: {stderr}"

    @pytest.mark.parametrize(
        "test_name,content",
        load_test_fragments(Path("tests/content-errors.typ")),
        ids=lambda x: x[0] if isinstance(x, tuple) else str(x),
    )
    def test_error_content(self, test_name, content, infomap_path):
        """Test content that should produce errors."""
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code != 0, f"Expected failure for '{test_name}' but compilation succeeded"


if __name__ == "__main__":
    args = [__file__] + sys.argv[1:]
    pytest.main(args)
