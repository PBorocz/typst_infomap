# Information Mapping for Typst

A simple Typst library implementing 'Information Mapping' methodology for creating structured, professional documents with consistent formatting and clear visual hierarchy.

## Overview

Information Mapping is a structured writing methodology that emphasizes:
- **Chunking**: Breaking information into digestible units
- **Labeling**: Clear, descriptive headings for each section
- **Relevance**: Grouping related information together
- **Consistency**: Standardized formats throughout
- **Visual Structure**: Clean layouts with proper spacing and hierarchy

This library provides Typst functions that make it easy to create documents following these principles.

## Features

### Document Structure
- **Map**: Document-level setup with headers, footers, and consistent typography
- **Section**: Major document divisions with automatic styling
- **Block**: Core content blocks with hanging titles and horizontal separators

### Tables
- **ModernTable**: Clean tables with header emphasis and minimal borders
- **ClassicTable**: Traditional bordered tables with consistent alignment
- **ProcessTable**: Step-numbered tables for procedures and workflows

### Lists and Procedures
- **Procedures**: Numbered steps with boxed numbers and proper alignment
- **Definitions**: Term-definition pairs with consistent formatting
- **References**: Cross-reference blocks with arrow indicators

### Typography
- Base font size system with relative scaling
- Consistent spacing and margins
- Sans-serif headers and footers with serif body text
- Automatic page numbering and date stamps

## Installation

1. Download `infomap.typ` to your project directory
2. Import the library in your Typst documents:

```typst
#import "infomap.typ": *
```

## Quick Start

```typst
#import "infomap.typ": *
#show: Map.with("Document Title")

#Section("Introduction")[
  #Block("Overview")[
	This document demonstrates Information Mapping principles
	using structured content blocks and consistent formatting.
  ]

  #Block("Key Features")[
	The main advantages include:
	- Clear visual hierarchy
	- Consistent formatting
	- Easy maintenance
  ]
]

#Section("Process Details")[
  #ProcessTable(
	"Assembly Steps",
	"Remove components from packaging",
	"Connect power supply to main unit",
	"Run initial system diagnostics"
  )
]
```

## Function Reference

### Document Setup

#### `Map(title, content)`
Sets up document-wide formatting including headers, footers, margins, and typography.

```typst
#show: Map.with("My Document Title")
```

**Features:**
- Custom title with "(continued)" on subsequent pages
- Date in footer (left) and page numbers (right)
- Sans-serif headers/footers, serif body text
- Consistent margins and spacing

### Content Structure

#### `Section(title, content)`
Creates major document sections with emphasized titles.

```typst
#Section("Section Title")[
  // Content blocks go here
]
```

#### `Block(title, content...)`
Core Information Mapping content blocks with hanging titles.

```typst
#Block("Block Title")[
  First paragraph of content.
][
  Second paragraph of content.
]
```

**Features:**
- Horizontal line separator above each block
- Left-hanging bold title
- Proper spacing between paragraphs

### Tables

#### `ModernTable(headers, rows...)`
Clean tables with minimal borders and header emphasis.

```typst
#ModernTable(
  ("Column 1", "Column 2", "Column 3"),
  ("Data 1-1", "Data 1-2", "Data 1-3"),
  ("Data 2-1", "Data 2-2", "Data 2-3")
)
```

#### `ClassicTable(headers, rows...)`
Traditional bordered tables.

```typst
#ClassicTable(
  ("Header A", "Header B"),
  ("Value 1", "Value 2"),
  ("Value 3", "Value 4")
)
```

#### `ProcessTable(description_header, steps...)`
Automatically numbered process tables.

```typst
#ProcessTable(
  "Installation Steps",
  "Download the software package",
  "Run the installer as administrator",
  "Follow the setup wizard prompts"
)
```

### Lists and Procedures

#### `Procedures(title, steps)`
Numbered procedures with boxed step numbers.

```typst
#Procedures("Setup Process", (
  "First step description",
  "Second step description",
  "Final step description"
))
```

#### `Definitions(term_definition_pairs)`
Structured definition lists.

```typst
#Definitions((
  ("API", "Application Programming Interface"),
  ("CPU", "Central Processing Unit"),
  ("RAM", "Random Access Memory")
))
```

#### `References(title, items)`
Cross-reference blocks with consistent formatting.

```typst
#References("Related Topics", (
  "Section 2.1: Basic Concepts",
  "Appendix A: Troubleshooting Guide",
  "Chapter 5: Advanced Features"
))
```

## Development

### Building Sample Documents

This project includes a `justfile` for easy compilation of sample documents:

```bash
# Compile all samples
just

# Compile specific sample
just compile a

# Clean generated PDFs
just clean

# Watch for changes and auto-recompile
just watch a

# List all available commands
just --list
```

### Testing

The library includes comprehensive tests using pytest:

```bash
# Install dependencies
pip install pytest

# Run all tests
python test_infomap.py

# Run with verbose output
python test_infomap.py -v

# Run specific tests
python test_infomap.py -k "test_valid_block"
```

**Test Features:**
- Validates successful compilation of all functions
- Tests assertion failures for invalid inputs
- Uses temporary directories for isolated testing
- Automatic cleanup of test artifacts

### Project Structure

```
├── infomap.typ           # Main library file
├── test_infomap.py       # Test suite
├── justfile              # Build automation for managing sample files.
├── samples/              # Example documents
│   ├── full_document.typ
│   ├── electronic_product_policy.typ
│   └── infomap.typ       # Symlink to main library
└── README.md
```

## Customization

### Font Sizing
All font sizes are based on `base-size` for easy scaling:

```typst
#let base-size = 16pt  // Increase for larger documents

// Functions automatically scale:
// Headers: base-size + 2pt
// Small text: base-size - 2pt
// etc.
```

### Styling
Override default styles by modifying the library or using Typst's `#show` rules:

```typst
#show list: set list(marker: "→")  // Custom bullet points
#set text(font: "Arial")           // Change default font
```

## Examples

See the `samples/` directory for complete example documents demonstrating:
- Multi-section documents with complex layouts
- Integration of tables, lists, and procedures
- Proper Information Mapping structure and flow

## Requirements

- Typst 0.11.0 or later
- For development and testing:
  - [python 3.11+](https://www.python.org/downloads/)
  - [uv](https://docs.astral.sh/uv/#installation) (for package management)
  - [just](https://just.systems/man/en/) (to manage generation of sample files)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Open a PR!

## Acknowledgments

Based on Information Mapping methodology developed by Robert Horn. Designed for the Typst typesetting system.
