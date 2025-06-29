#import "infomap.typ": *
#show: Map.with("Sample Map")

// Usage:
#Section("A Section Heading")[

    #Block("Block with Text")[#lorem(50)]

    #Block("Block with Classic Table")[

        This is a sample block that contains a simple, "classic" table.

        #ClassicTable(
            ("Long Column 1", "Column 2", "Column 3"),
            ("1-1", "Datum 1-2", "Datum 1-3"),
            ("2-1", "Datum 2-2", "Datum 2-3"),
            ("3-1", "Datum 3-2", lorem(20)),
        )
    ]

    #Block("Block with Modern Table")[

        This is a sample block that contains a simple, modern table (the Classic table above *really* looks _old_ to my eyes even though I lived through the era!)

        #ModernTable(
            ("Column 1", "Column 2", "Column 3"),
            ("Datum 1-1", "Datum 1-2", "Datum 1-3"),
            ("Datum 2-1", "Datum 2-2", "Datum 2-3"),
            ("Datum 3-1", "Datum 3-2", "Datum 3-3"),
        )
    ]

    #Block("Block with Process Table")[

        This is a sample block that contains an auto-numbered "process" table (ie, steps, stages etc.)

        #ProcessTable(
            "Step",
            "Action",
            "Open the box.",
            [Look inside...

                - evaluate the beauty
                - smell the aroma (?!)
                - decide how long you want to keep doing this.
            ],
            "Close the box"
        )
    ]

    #Block("\"Regular\" Typography")[

        List items are used *as is* with no special markup required:

        // Bulleted List items
        - Item 1
        - Item 2
        - Item 3

        // Numbered List items
        1. Step A
        2. Step B
        3. Step C
    ]

    // Procedure
    #Block(Procedures)[
        Procedures to explain how to do something (see also "#ProcessTable")...

        #Procedures("How to Install",
            (
                "Download file",
                "Run installer",
                "Follow prompts"
            ))
    ]

    // Definitions
    #Block(Definitions)[
        When we want to provide definitions...

        #Definitions(
            (
                ("API", "Application Programming Interface"),
                ("CPU", "Central Processing Unit")
            ))
    ]

    // References
    #Block(References)[
        Dedicated format to provide references...

        #References("Related Topics",
            ("Section 2.1: Basic Concepts", "Appendix A: Troubleshooting")
        )
    ]

]

#Section("SECOND SECTION HEADING")[
    #Block("Multi-Page Block")[
        Another Block with a LOT of text to see happens on pagination.

        #ModernTable(
            ("Long Column Title 1", "Column 2", "Column 3"),
            ("1-1", "Datum 1-2", "Datum 1-3"),
            ("2-1", "Datum 2-2", "Datum 2-3"),
            ("3-1", "Datum 3-2", "Datum 3-3"),
        )

        #lorem(1000)
    ]
]

#Section("Small Section #1")[
    #Block("Small Section Block")[
        #lorem(100)
    ]
]

#Section("Small Section #2")[
    #Block("Another Small Section Block")[
        #lorem(100)
    ]
]
