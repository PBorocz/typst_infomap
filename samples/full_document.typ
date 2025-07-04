#import "infomap.typ": *
#show: Document.with("Sample Map")

// Usage:
#Map("A Map Heading")[

    #Block("Block with Text")[#lorem(50)]
]

#Map("Tabular Information Types")[
    #Block("Procedures")[
        We can present procedures as either "Step/Action" or "If/Then" tables:
        #Table-StepAction(
            "Open the box.",
            [Look inside...
                - evaluate the beauty
                - smell the aroma (?!)
                - decide how long you want to keep doing this.
            ],
            "Close the box"
        )
        #Table-IfThen(
            ("The box is not already open", "Open the box"),
            ("The box is empty", "Call the manufacturer"),
            ("The item is damaged", "Call the shipper."),
        )
    ]

    #Block("Processes")[
        We can present processes as either "Stage/Description" or "When/Then" tables (I don't see much distinction between If/Then and When/Then though)
        #Table-StageDescription(
            ("Startup", "Start the engine using either the pull-string or electronic ignition (if available)."),
            ("Run it..", "Mow your lawn"),
            ("Shutdown", "Shut down your engine, _carefully_ check for debris"),
        )
        #Table-WhenThen(
            ("The blade doesn't seem to cut cleanly", "Sharpen it"),
            ("The engine doesn't start", "Check for gas in the tank"),
        )
    ]

    #Block("Structures")[

        We can present structural information using either Part/Function or Part/Description tables (FWIW, I don't see much distinction between these though).

        #Table-PartFunction(
            ("Blade", "Cuts the grass"),
            ("Engine", "Rotates the blade through one or more pistons and internal combustion"),
            ("Fuel Tank", "Holds gasoline for the engine"),
        )

        #Table-PartDescription(
            ("Blade", "Cuts the grass"),
            ("Motor", "Transfers electrical current into rotation velocity to rotate the blade"),
            ("Battery", "Rechargeable cell to provide electricity to run the motor"),
        )

    ]
]
#Map("Typography")[

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

    #Block("Block with Classic Table")[

        This is a sample block that contains a simple, "classic" table.

        #Table-Classic(
            ("Long Column 1", "Column 2", "Column 3"),
            ("1-1", "Datum 1-2", "Datum 1-3"),
            ("2-1", "Datum 2-2", "Datum 2-3"),
            ("3-1", "Datum 3-2", lorem(20)),
        )
    ]

    #Block("Block with Modern Table")[

        This is a sample block that contains a simple, modern table (the Classic table above *really* looks _old_ to my eyes even though I lived through the era!)

        #Table-Modern(
            ("Column 1", "Column 2", "Column 3"),
            ("Datum 1-1", "Datum 1-2", "Datum 1-3"),
            ("Datum 2-1", "Datum 2-2", "Datum 2-3"),
            ("Datum 3-1", "Datum 3-2", "Datum 3-3"),
        )
    ]

    // Procedure
    #Block(Procedures)[
        Procedures to explain how to do something (see also "#Table-StepAction")...

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
            ("Map 2.1: Basic Concepts", "Appendix A: Troubleshooting")
        )
    ]

]

#Map("SECOND MAP HEADING")[
    #Block("Multi-Page Block")[
        Another Block with a LOT of text to see happens on pagination.

        #Table-Modern(
            ("Long Column Title 1", "Column 2", "Column 3"),
            ("1-1", "Datum 1-2", "Datum 1-3"),
            ("2-1", "Datum 2-2", "Datum 2-3"),
            ("3-1", "Datum 3-2", "Datum 3-3"),
        )

        #lorem(1000)
    ]
]

#Map("Small Map #1")[
    #Block("Small Map Block")[
        #lorem(100)
    ]
]

#Map("Small Map #2")[
    #Block("Another Small Map Block")[
        #lorem(100)
    ]
]
