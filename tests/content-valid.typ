--- Simplest Map
#import "infomap.typ": *
#Map("Valid Map")[
    #Block("Block Title")[Some content here.]
]

--- Standalone Block Test
#import "infomap.typ": *
#Block("Block Title")[This is valid content.]

--- Process Table with Steps
#import "infomap.typ": *
#Table-StepAction(
    "Step 1 description",
    "Step 2 description",
    "Step 3 description"
)

--- Procedures Function
#import "infomap.typ": *
#Procedures("Test Procedure", (
    "First step",
    "Second step",
    "Third step"
))

--- Definitions Function
#import "infomap.typ": *
#Definitions((
    ("API", "Application Programming Interface"),
    ("CPU", "Central Processing Unit")
))

--- Valid Modern Table
#import "infomap.typ": *
#Table-Modern(
    ("Header1", "Header2"),
    ("Data1", "Data2"),
    ("Data3", "Data4")
)

--- Valid Classic Table
#import "infomap.typ": *
#Table-Classic(
    ("Header1", "Header2"),
    ("Data1", "Data2"),
    ("Data3", "Data4")
)

--- Full Document Structure
#import "infomap.typ": *
#show: Document.with("Test Document")

#Map("First Map")[
    #Block("Introduction")[
        This is introductory content.
    ]

    #Block("Data Table")[
        #Table-Modern(
            ("Item", "Count"),
            ("Apples", "5"),
            ("Oranges", "3")
        )
    ]
]
