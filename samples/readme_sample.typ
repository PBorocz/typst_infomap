#import "infomap.typ": *
#show: Document.with("Document Title")


#Map("A Map")[

    #Block("Overview")[
        This document demonstrates Information Mapping® principles using structured content blocks and consistent formatting.

        Key features include:

        - Clear visual hierarchy
        - Consistent formatting
        - Easy maintenance
    ]

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
