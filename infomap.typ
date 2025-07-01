// ## Minor Improvements

// **1. Consistent naming for ProcessTable:**
// ```typst
// #let ProcessTable(description_header, ..steps) = [
//   #table(
//     columns: 2,
//     stroke: 0.75pt,
//     align: (center, left),

//     [*Step*],  // Hardcode "Step" since it's always the same
//     [*#description_header*],

//     ..steps.pos().enumerate().map(((index, step)) => (
//       [#(index + 1)],
//       [#step]
//     )).flatten()
//   )
// ]
// ```

// **2. Add consistent spacing after elements:**
// ```typst
// #let Section(title, blocks) = [
//     // ... existing code ...
//     #blocks
//     #v(1em)  // Add consistent spacing after sections
// ]
// ```

// **3. Consider making margins consistent with base-size:**
// ```typst
// margin: (left: base-size * 0.7, right: base-size * 0.7, top: base-size * 2.1, bottom: base-size * 1.4),
// ```

// **4. Add a comment block at the top:**
// ```typst
// /*
//  * Information Mapping Library for Typst
//  * Provides structured document formatting following IM methodology
//  * Usage: #import "infomap.typ": *
//  *        #show: Map.with("Document Title")
//  */
// ```

// **5. Consider adding error checking:**
// ```typst
// #let Block(title, ..content) = {
//   assert(title != none and title != "", message: "Block title cannot be empty")
//   // ... rest of function
// }
// ```

// **6. Optional: Add a utility for consistent spacing:**
// ```typst
// #let spacing = (
//   small: base-size * 0.25,
//   medium: base-size * 0.5,
//   large: base-size * 1.0
// )
// ```

// Overall, this is excellent work! The library is well-structured, consistent, and follows good Typst practices.



//
// "Information Mapping" formatting  utilities for Typst
// Provides structured document formatting following information mapping methodology
//
// Usage: #import "infomap.typ": *
//        #show: Map.with("Document Title")
//
// Note: This is completely independent of Information Mapping the company. They retain all rights to
// the methodology and no ownership or claims are intended by release of these utilities.
//
//

// Document Defaults
#let base-size = 14pt // All other sizes are expressed as deltas from this!

// Simple overrides (not worth setting up dedicated functions for)
#show list: set list(marker: "•", indent: 1em, body-indent: 0.5em)

// =============================================================================
// Setup up our "Map", used like this:
// #import "infomap.typ": *
// #show: Map.with("This is our Map Title")
// =============================================================================
#let Map(title, sections_or_blocks) = [
    #assert(title != none and title != "", message: "Sorry, Map title is required.")
    #set par(justify: false)
    #set text(size: base-size)
    #set page(
        paper: "us-letter",

        margin: (left: 1cm, right: 1cm, top: 3cm, bottom: 2cm),

        header: context [
            #if counter(page).get().first() == 1 [
                #set text(size: base-size + 2pt, weight: "bold", font: "Arial")  // or "Helvetica", "Liberation Sans", etc.
                #align(left, title)
            ] else [
                #text(size: base-size + 2pt, weight: "bold", font: "Arial")[#title]
                #text(size: base-size - 2pt, weight: "regular", fill: gray)[(continued)]
            ]
        ],
        header-ascent: 2em,  // Increase this value for more space below header

        footer: context [
            #set text(base-size - 6pt, font: "Arial") // With context, this pertains to just the footer.
            #grid(
                columns: (1fr, 1fr),
                align: (left, right),
                datetime.today().display(),
                counter(page).display("1 of 1", both: true)
            )
        ],
        footer-descent: 2em,
    )

    #sections_or_blocks
]


// =============================================================================
// Display a selection, ie. a title and a set of blocks (ie. content)
// =============================================================================
#let Section(title, blocks) = [
    #assert(title != none and title != "", message: "Sorry, Section title is required.")
    #show heading.where(level: 2): it => text(fill: blue)[#it]
    #align(left)[#text(size: base-size + 2pt, weight: "bold")[#title]]
    #v(1em)
    #blocks
]

// =============================================================================
// Display a block, ie. a left-hanging title and indented content.
// =============================================================================
#let Block(title, ..content) = [
    #assert(title != none and title != "", message: "Sorry, Block title is required.")
    #grid(
        columns: (15%, auto),
        column-gutter: 1.25em,
        row-gutter: 0.5em,
        align: (left + top, left + top),

        // First row, empty cell followed by block line marker
        [],
        [ #line(length: 100%) #v(0.5em) ],

        // Second row: title and then content..
        [ #align(left)[ #text(weight: "bold", size: base-size - 1pt)[#title] ] ],

        [#content.pos().join([\ \ ])]
    )
    #v(0.5em)
]

// =============================================================================
#let Table-Modern(headers, ..rows) = [
  #table(
      columns: headers.len(),
      stroke: none,               // Turn stroke off as we'll control it explicitly below..
      align: left,
      table.hline(stroke: 1.5pt), // Heavy line above headers
      ..headers.map(h => [*#h*]), // Header row
      table.hline(stroke: 0.5pt), // Light line below headers
      ..rows.pos().flatten(),     // Data rows
      table.hline(stroke: 1.5pt), // Heavy line at bottom
  )
]

// =============================================================================
#let Table-Classic(headers, ..rows) = [
  #table(
      columns: headers.len(),
      stroke: 0.75pt,
      align: left,
      // If we want the first column centered but the rest left-aligned:
      // align: (center,) + (left,) * (headers.len() - 1),

      ..headers.map(h => [*#h*]),
      // If we want the headers centered:
      // ..headers.map(h => [*#align(center)[#h]*]),

      ..rows.pos().flatten(),
      // If we want the first cell centered and the rest left-aligned:
      // ..rows.pos().map(row => {
      //     (align(center)[#row.at(0)],) + row.slice(1)
      // }).flatten(),

  )
]

// =============================================================================
#let Table-Generic(headers, ..rows) = [
    // Generic 2-Column table, where both sets of columns are provided.
  #table(
      columns: headers.len(),

      stroke: 0.75pt,

      align: left,
      // If we want the first column centered but the rest left-aligned:
      // align: (center,) + (left,) * (headers.len() - 1),

      ..headers.map(h => [*#h*]),
      // If we want the headers centered:
      // ..headers.map(h => [*#align(center)[#h]*]),

      ..rows.pos().flatten(),
      // If we want the first cell centered and the rest left-aligned:
      // ..rows.pos().map(row => {
      //     (align(center)[#row.at(0)],) + row.slice(1)
      // }).flatten(),

  )
]

#let Table-AutoNum(header_column_1, header_column_2, ..steps) = [
    // Generic 2-Column table, where the 1st column is AUTONUMBERED!
    // Meant as a building block for more specific information types,
    // probably not to be used directly.
    #table(
        columns: 2,
        stroke: 0.75pt,
        align: (center, left),

        // Header row
        [*#header_column_1*],
        [*#header_column_2*],

        // Data rows with manual step numbering
        ..steps.pos().enumerate().map(((index, step)) => (
            [#(index + 1)], // Enumerate starts at 0
            [#step]
        )).flatten()
    )
]

// ========================================
// Table "macros" for simplicity in markup
// ========================================

// obo Procedure Information Type:
#let Table-StepAction(..steps) = [
    #Table-AutoNum("Step", "Action", ..steps)
]

#let Table-IfThen(..steps) = [
    #Table-Generic(("If", "Then"), ..steps)
]

// obo Process Information Type:
#let Table-StageDescription(..steps) = [
    #Table-Generic(("Stage", "Description"), ..steps)
]

#let Table-WhenThen(..steps) = [
    #Table-Generic(("When", "Then"), ..steps)
]

// obo Structure Information Type:
#let Table-PartFunction(..steps) = [
    #Table-Generic(("Part", "Function"), ..steps)
]

#let Table-PartDescription(..steps) = [
    #Table-Generic(("Part", "Description"), ..steps)
]


// Procedure/Step Lists**
#let Procedures(title, steps) = [
  #text(weight: "bold", size: base-size - 2pt)[#title]
  #v(0.5em)

  #let step_counter = counter("procedure-steps")
  #step_counter.update(0)

  #for step in steps [
    #context [
      #step_counter.step()
      #grid(
        columns: (3em, 1fr),
        column-gutter: 0.8em,
        align: (center + horizon, left + horizon),

        // Step number in box
        [#rect(
          width: 2em,
          height: 1.5em,
          stroke: 1pt,
          [#align(center + horizon)[#text(weight: "bold")[#step_counter.get().first()]]]
        )],

        // Step content
        [#step]
      )
    ]
    #v(0.25em)
  ]
]

// Definition Lists**
#let Definitions(term_def_pairs) = [
  #for (term, definition) in term_def_pairs [
    #grid(
      columns: (1fr, 7fr),
      column-gutter: 1em,
      align: (left + top, left + top),

      [#text(weight: "bold")[#term:]],
      [#definition]
    )
    #v(0.5em)
  ]
]

// Reference/Cross-Reference blocks**
#let References(title, items) = [
  #rect(
    width: 100%,
    stroke: 0.5pt + gray,
    inset: 1em,
    [
      #text(weight: "bold")[#title]
      #v(0.3em)

      #for item in items [
        #grid(
          columns: (1em, 1fr),
          column-gutter: 0.3em,
          [→],
          [#item]
        )
        #v(0.2em)
      ]
    ]
  )
]
