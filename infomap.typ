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
#let base-size = 12pt // All other sizes are expressed as deltas from this!
#let fonts_header_footer = ("Helvetica Neue", "Avenir Next", "Arial")
#let fonts_body = ("Libertinus Serif", "Helvetica", "Georgia")
#let current_datetime = sys.inputs.at("current_datetime", default: "")

#let spacing = (
    // Most of these are based on considering sample Information Mapping documents
    // and eye-balling the right amount of spacing.
    list-indent: 0em,
    body-indent: 0.5em,
    column-gutter: 1.25em,
    row-gutter: 0.5em,
)

// =============================================================================
// Setup up our "Document", used like this:
// #import "infomap.typ": *
// #show: Document.with("This is our Map Title")
// =============================================================================
#let Document(title, maps_or_blocks) = [
    #assert(title != none and title != "", message: "Sorry, a Document title is required.")
    #set par(justify: false)
    #set text(size: base-size, font: fonts_body)
    #set page(
        paper: "us-letter",

        margin: (left: 1cm, right: 1cm, top: 3cm, bottom: 2cm),

        footer: context [
            #set text(base-size - 6pt, font: fonts_header_footer) // Since we're in context, this pertains to just the footer.
            #grid(
                columns: (1fr, 1fr, 1fr),
                align: (left, center, right),
                [#if current_datetime != "" [Generated: #current_datetime]],
                [#title],
                counter(page).display("1 of 1", both: true)
            )
        ],
        footer-descent: 18pt
    )
    #show list: set list(marker: "•", indent: spacing.list-indent, body-indent: spacing.body-indent)
    #show link: it => underline(text(fill: blue, size: base-size - 1pt)[#it])

    #maps_or_blocks
]

// =============================================================================
// Display/Define a new Map, ie. a new page, page-header and left-hanging title and indented content.
// =============================================================================
#let map_pages = state("map-pages", (:)) // Cache of map-titles seen thus far.

#let Map(map_title, blocks) = [
    #assert(map_title != none and map_title != "", message: "Sorry, a Map title is required.")
    #context {
        let current_page = counter(page).get().first()
        map_pages.update(pages => {
            if map_title not in pages {
                // Note: We ARE assuming here someone won't use Title-1,
                // Title-2 and then Title-1 again in the same document!
                pages.insert(map_title, current_page)
            }
            pages
        })
    }
    #set page(
        header: context [
            #let current_page = counter(page).get().first()
            #let start_page = map_pages.get().at(map_title, default: current_page)

            #align(left)[
                // Always display our Map Title but add a "continued" if it's a subsequent page.
                #text(size: base-size + 2pt, weight: "bold", font: fonts_header_footer)[#map_title]
                #if current_page != start_page [
                    #text(size: base-size - 2pt, weight: "regular", font: fonts_header_footer, fill: gray)[(continued)]
                ]
            ]
        ],
        header-ascent: 20pt
    )
    #blocks
]

// =============================================================================
// Display a block, ie. a left-hanging title and indented content.
// =============================================================================
#let Block(title, ..content) = [
    #assert(title != none and title != "", message: "Sorry, Block title is required.")
    #grid(
        columns: (15%, auto),
        column-gutter: spacing.column-gutter,
        row-gutter: spacing.row-gutter,
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
