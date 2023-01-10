# -*- coding: utf-8 -*-
from odoo import http


class Books(http.Controller):
    @http.route("/library/books")
    def list(self, **kwargs):
        books = http.request.env["library.book"].search([])
        return http.request.render(
            "library_app.book_list_template",
            {"books": books}
        )


class LibraryApp(http.Controller):
    @http.route('/library/hello', auth='public')
    def index(self, **kw):
        books = http.request.env["library.book"].search([])
        books_list_as_string = ", ".join([book.name for book in books])
        return f"Hello, world, here are the books: {books_list_as_string}"

#     @http.route('/library_app/library_app/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('library_app.listing', {
#             'root': '/library_app/library_app',
#             'objects': http.request.env['library_app.library_app'].search([]),
#         })

#     @http.route('/library_app/library_app/objects/<model("library_app.library_app"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('library_app.object', {
#             'object': obj
#         })
