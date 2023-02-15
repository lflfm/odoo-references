{
    "name": "Library Members",
    "license": "AGPL-3",
    "description": "Manage members borrowing books.",
    "author": "Daniel Reis",
    "depends": ["library_app"],
    "application": False,
    "data": [  # The order used to load data files is important since references can only use IDs that have already been defined. It is common for menu items to reference security groups, and so it is a good practice to add security definitions before menu and view definitions.
        "views/book_view.xml",
    ],
}
