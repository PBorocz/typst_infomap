#import "infomap.typ": *
#show: Map.with("Electronic Product Defect/Non-Compliance Policy")

// Usage:

#Block("Introduction")[
    This topic explains FDA policy for an electronic product defect or non-compliance as determined by the Secretary of the FDA.
]

#Block("Regulations")[
    This policy originates from the following regulations:
    
    - Section 535(a) of the Federal Food, Drug, and Cosmetic Act
- Sub-chapter C – Electron Product Radiation Control (P.L. 90-602), and
- 1003.11 of the implementing regulations (21 CFR 1003.11).
]

#Block("Policy")[
    The manufacturer is responsible for product defects or non-compliance.
]

#Block("Secretary's Responsibility")[
    The Secretary determines whether an electronic product:
    
    - does not comply with an applicable Federal performance standard, or
- has a defect that relates to the safety or use of the product.
]

#Block("Manufacturer's Responsibility")[
    The manufacturer bears the burden of proof for defending an allegation of a product defect or non-compliance.
]

#Block("Process")[
    The table below describes the process for notification and resolution of a product defect or non-compliance.
    
    #ProcessTable(
        "Stage",
        "Description",
        "FDA determines that an electronic product has a defect or is not in compliance.",
        [FDA provides the manufacturer with written notification containing a(n),
            
            - explanation of the alleged defect or non-compliance
            - FDA findings including information on which the findings are based, and
            - reasonable time-frame in which the manufacturer may defend the allegation.
        ],
        [The manufacturer presents evidence to establish that the defect or non-compliance is due to a cause other than faulty manufacture, such as
            
            - modification of equipment by unauthorized personnel
            - installation of improper replacement parts or materials, or
            - unforeseeable equipment abuse by an owner or user.
        ],
        [The information in the table below explains what happens next.
            #ClassicTable(
                ("When the manufacturer is ...", "Then the FDA ..."),
                ("able to prove that the defect or non compliance is not due to faulty manufacture", "does not require the manufacturer to repair, replace, or refund the product."),
                ("unable to prove that the defect or noncompliance is not due to faulty manufacture", "requires the manufacturer to repair, replace, or refund the product.")
            )
        ],
    )
]

#Block("Example of Non-Compliance")[
    A certain amount of normal wear and tear occurs in electronic products.

    However, if normal wear and tear results in radiation emitted by the product exceeding the limit prescribed in the acceptable standard, the manufacturer may be charged with non-compliance because of failure to design the product to maintain an acceptable level of radiation leakage over its useful life.
]

#Block("Policy Issue Dates")[

    #ModernTable(
        ("Action", "Date(s)"),
        ("Issued", "8/23/1974"),
        ("Reissued", "6/11/1978"),
        ("Revised", "10/1/1980, 9/24/1987, 3/1995")
    )
]
