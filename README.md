# Information Mapping for Typst

A simple Typst library implementing the "Information Mapping®" formatting to create structured documents with consistent formatting and clear visual hierarchy.

## Background

"Information Mapping®" is a structured writing methodology that recognises that the majority of writing for professional purposes fall into one of size information _types_:

| Type          | Description                               |
|---------------|-------------------------------------------|
| **Procedure** | Instructions on how to do something       |
| **Process**   | Description of how something works        |
| **Principle** | Description of a standard or a convention |
| **Concept**   | Description of a new idea or object       |
| **Structure** | Description of an object’s components     |
| **Fact**      | Empirical information                     |

Presenting content across these information types must reflect the following principles:

- **Chunking**: Break information into digestible units
- **Labeling**: Provide clear, descriptive headings for each section
- **Relevance**: Group related information together in a consistent format

From a practical perspective, the tools provided by Information Mapping® over the last several decades emphasise both consistency and a clean visual structure.

Over the years, I've found the presentational aspects of Information Mapping® extremely valuable; almost "forcing" you to incorporate the principles above through a structured meta-model yet providing an easy-to-navigate (almost speed-read) through complex material.

However, I've also always found it difficult to manually achieve this formatting. After considering the use of LaTeX (through the excellent [limap](https://ctan.org/pkg/limap "limap") package), I found the [Typst](https://typst.app/ "Typst") environment. While still embedding markup in content, this seemed a much more modern and friendly environment for high-quality pdf generation.

## Installation

1. Download `infomap.typ` to your project directory.
2. Import the library in your Typst documents:

```typst
#import "infomap.typ": *
```

## Features

### Faithful Meta-Document Model

As close to a _true_ model of the original method as I could do, incorporating the following _meta\-model_:

- **Map**: Document-level setup with headers, footers, and consistent typography; Can contain either one or many Sections or Blocks
- **Section**: Major divisions with automatic styling (optional); Can contain one or many Blocks
- **Block**: Core content blocks with hanging titles and horizontal separators; Can contain other Blocks.

### Consistent Typography
- Base font size system with relative scaling
- Consistent spacing and margins
- Sans-serif headers and footers with serif body text
- Automatic page numbering and date stamps.

## Sample Document

(This can also be found in the samples directory [readme_sample.typ](sample/readme_sample.typ))

```typst
#import "infomap.typ": *
#show: Map.with("Document Title")

#Block("Overview")[
	This document demonstrates Information Mapping® principles
	using structured content blocks and consistent formatting.

	Key features include:

	- Clear visual hierarchy
	- Consistent formatting
	- Easy maintenance
]

#Section("A Section")[
	#Block("A Block")[
		#lorem(30)
	]
	#Block("How To Start Your Unit")[
		#Table-StepAction(
			"Remove components from packaging.",
			"Connect power supply to main unit.",
			"Run initial system diagnostics."
		)
	]
]
```

## Function Reference

### Document Setup

#### `Map(title)`
Sets up document-wide formatting:
- Custom title with "(continued)" on subsequent pages
- Date in footer (left) and page numbers (right)
- Sans-serif headers/footers, serif body text
- Consistent margins and spacing

```typst
#show: Map.with("My Document Title")
```

### Content Structure

#### `Section(title, content)`
Creates major document sections with emphasized titles.

```typst
#Section("Section Title")[
  // Content blocks go here
]
```

#### `Block(title, content...)`
Core content blocks with
- Horizontal line separator above each block
- Left-hanging bold title
- Proper spacing between paragraphs

```typst
#Block("Block Title")[
  First paragraph of content.
][
  Second paragraph of content.
]
```

### Information Type-Based Tables

For use in Procedure, Process and Structure information types, we provide bespoke table to ease content creation. For example:

```typst
#Table-StepAction(
  "Open the box.",
  "Look inside...",
  "Close the box",
)

#Table-IfThen(
  ("The box is not already open", "Open the box"),
  ("The box is empty", "Call the manufacturer"),
  ("The item is damaged", "Call the shipper."),
)
```

Also provided are:

```
#Table-StageDescription(..(stage, description))
#Table-WhenThen(..(when, then))
#Table-PartDescription(..(part, description))
```


### Custom Non-Tabular Lists

#### `Procedures(title, steps)`
Numbered procedures with boxed step numbers and proper alignment.

```typst
#Procedures("Setup Process", (
  "First step description",
  "Second step description",
  "Final step description"
))
```

#### `Definitions(term_definition_pairs)`
Term-definition pairs with consistent formatting.

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

### Raw Tables

When dedicated tables based on information type aren't sufficient, two generic tables layouts are also provided (and serve as underlying tables for those above).

#### `Table-Modern(headers, rows...)`
Clean tables with minimal borders and header emphasis.

```typst
#Table-Modern(
  ("Column 1", "Column 2", "Column 3"),
  ("Data 1-1", "Data 1-2", "Data 1-3"),
  ("Data 2-1", "Data 2-2", "Data 2-3")
)
```

#### `Table-Class(headers, rows...)`
Traditional bordered tables meant to look more like "classic" Microsoft Word tables from the 1990's.

```typst
#Table-Classic(
  ("Header A", "Header B"),
  ("Value 1", "Value 2"),
  ("Value 3", "Value 4")
)
```

#### `Table-StepAction(description_header, steps...)`
Automatically numbered step/action tables.

```typst
#Table-StepAction(
  "Installation Steps",
  "Download the software package",
  "Run the installer as administrator",
  "Follow the setup wizard prompts"
)
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

## Requirements

- Typst 0.11.0 or later
- For development and testing:
  - [python 3.11+](https://www.python.org/downloads/)
  - [uv](https://docs.astral.sh/uv/#installation) (for package management)
  - [just](https://just.systems/man/en/) (to manage generation of sample files)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Trademark Notice

Information Mapping® is a trademark of Information Mapping, Inc. This project implements formatting concepts and methodologies inspired by Information Mapping® principles for use with the Typst typesetting system.

This project is not affiliated with, endorsed by, or sponsored by Information Mapping, Inc. The use of Information Mapping® concepts and terminology in this project does not imply any ownership, endorsement, or commercial relationship with Information Mapping, Inc.

The trademark rights remain with their respective owners.

## Contributing

Open a PR!

## References

- [Information Mapping](https://informationmapping.com/)
- [Typst](https://typst.app/ "Typst")
- [limap](https://ctan.org/pkg/limap "limap")
- [Introduction to Information Mapping by Iva Cheung](https://ivacheung.com/2012/11/introduction-to-information-mapping/)
