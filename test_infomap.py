"""Test script.."""
#!/usr/bin/env python3
#
# Use PEP723 to not need a dedicated venv, rely upon uv to do so dynamically!:
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
        """Run a typst test with the given content.

        Returns:
            tuple: (return_code, stdout, stderr)
        """
        # Create a test/temporary subdirectory UNDER our current one
        current_dir = Path.cwd()
        temp_dir = current_dir / f"temp_typst_test_{os.getpid()}_{id(self)}"
        temp_dir.mkdir(exist_ok=True)

        # Write the test content to the temp_file
        temp_file = temp_dir / "test.typ"
        with open(temp_file, "w") as f:
            f.write(typst_content)
        temp_output = temp_dir / "test.pdf"

        try:
            # Copy infomap.typ to temp directory (since it won't find it even a single directory above :-()
            shutil.copy2(infomap_path, temp_dir / "infomap.typ")

            # Run typst compile on the temporary file
            result = subprocess.run(
                ["typst", "compile", temp_file, temp_output],
                capture_output=True,
                text=True,
                timeout=30,
                cwd=str(temp_dir),  # Run from the temp directory
            )
            return result.returncode, result.stdout, result.stderr
        except subprocess.TimeoutExpired:
            return -1, "", "Timeout expired"
        finally:
            try:  # Clean up temporary directory and all contents
                shutil.rmtree(temp_dir)
            except (FileNotFoundError, PermissionError):
                pass

    def test_valid_block(self, infomap_path):
        """Test that a valid Block compiles successfully."""
        content = f"""
    #import "{infomap_path}": *

    #Block("Valid Title")[This is valid content.]
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_block_empty_title_assertion(self, infomap_path):
        """Test that Block with empty title triggers assertion."""
        content = f"""
    #import "{infomap_path}": *

    #Block("")[This should fail due to empty title.]
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code != 0, "Expected assertion failure for empty title"
        assert "assertion" in stderr.lower(), f"Expected assertion error in: {stderr}"

    def test_block_none_title_assertion(self, infomap_path):
        """Test that Block with none title triggers assertion."""
        content = f"""
    #import "{infomap_path}": *

    #Block(none)[This should fail due to none title.]
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code != 0, "Expected assertion failure for none title"

    def test_valid_section(self, infomap_path):
        """Test that a valid Section compiles successfully."""
        content = f"""
    #import "{infomap_path}": *

    #Section("Valid Section")[
        #Block("Block Title")[Some content here.]
    ]
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_valid_modern_table(self, infomap_path):
        """Test that ModernTable works correctly."""
        content = f"""
    #import "{infomap_path}": *

    #ModernTable(
        ("Header1", "Header2"),
        ("Data1", "Data2"),
        ("Data3", "Data4")
    )
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_valid_classic_table(self, infomap_path):
        """Test that ClassicTable works correctly."""
        content = f"""
    #import "{infomap_path}": *

    #ClassicTable(
        ("Header1", "Header2"),
        ("Data1", "Data2"),
        ("Data3", "Data4")
    )
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_process_table_with_steps(self, infomap_path):
        """Test ProcessTable with multiple steps."""
        content = f"""
    #import "{infomap_path}": *

    #ProcessTable(
        "Step",
        "Action",
        "Step 1 description",
        "Step 2 description",
        "Step 3 description"
    )
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_procedures_function(self, infomap_path):
        """Test Procedures function."""
        content = f"""
    #import "{infomap_path}": *

    #Procedures("Test Procedure", (
        "First step",
        "Second step",
        "Third step"
    ))
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_full_document_structure(self, infomap_path):
        """Test a complete document structure."""
        content = f"""
    #import "{infomap_path}": *
    #show: Map.with("Test Document")

    #Section("First Section")[
        #Block("Introduction")[
            This is introductory content.
        ]

        #Block("Data Table")[
            #ModernTable(
                ("Item", "Count"),
                ("Apples", "5"),
                ("Oranges", "3")
            )
        ]
    ]

    #Section("Process Section")[
        #ProcessTable(
            "Assembly Steps",
            "Attach component A",
            "Connect to component B",
            "Test functionality"
        )
    ]
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    def test_definitions_function(self, infomap_path):
        """Test Definitions function."""
        content = f"""
    #import "{infomap_path}": *

    #Definitions((
        ("API", "Application Programming Interface"),
        ("CPU", "Central Processing Unit")
    ))
    """
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code == 0, f"Expected success but got error: {stderr}"

    @pytest.mark.parametrize(
        "invalid_input",
        [
            '""',  # Empty string
            "none",  # None value
        ],
    )
    def test_block_invalid_titles(self, infomap_path, invalid_input):
        """Test various invalid title inputs for Block function."""
        content = f"""
#import "{infomap_path}": *
#Block({invalid_input})[Content here.]
"""
        return_code, stdout, stderr = self.run_typst_test(content, infomap_path)
        assert return_code != 0, f"Expected failure for invalid input: {invalid_input}"


if __name__ == "__main__":
    # % uv run test_infomap.py
    args = [__file__] + sys.argv[1:]
    pytest.main(args)
