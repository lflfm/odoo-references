{
    "name": "Library Management",
    "summary": "Manage library catalog and book lending.",
    "author": "Luiz Following Packt Tutorial",
    "license": "AGPL-3",
    "website": "https://github.com/PacktPublishing/Odoo-15-Development-Essentials",
    "version": "16.0.1.0.0",
    "category": "Services/Library",
    "depends": ["base"],
    "data": [  # The order used to load data files is important since references can only use IDs that have already been defined. It is common for menu items to reference security groups, and so it is a good practice to add security definitions before menu and view definitions.
        "security/library_security.xml",
        "security/ir.model.access.csv",
        "views/book_view.xml",
        "views/library_menu.xml",
        "views/book_list_template.xml",
    ],
    "application": True,
}
