from odoo import fields, models
from odoo.exceptions import ValidationError


class Book(models.Model):
    _name = "library.book"
    _description = "Book"
    name = fields.Char("Title", required=True)
    isbn = fields.Char("ISBN")
    active = fields.Boolean("Active?", default=True)
    date_published = fields.Date()
    image = fields.Binary("Cover")
    publisher_id = fields.Many2one("res.partner", string="Publisher")
    author_ids = fields.Many2many("res.partner", string="Authors")

    def button_check_isbn(self):
        for book in self:
            if not book.isbn:
                raise ValidationError(f"Please provide an ISBN for {book.name}")
            if not book._check_isbn():
                raise ValidationError(f"{book.isbn} ISBN is invalid")
        return True

    def _check_isbn(self):
        if self.isbn:
            isbn = self.isbn.replace("-", "")
            if len(isbn) != 13:
                return False
            try:
                int(isbn)
            except ValueError:
                return False
            odd = sum(int(isbn[x]) for x in range(0, 12, 2))
            even = sum(int(isbn[x]) for x in range(1, 12, 2))
            total = odd + (even * 3)
            check = 10 - (total % 10)
            if check == 10:
                check = 0
            return check == int(isbn[-1])
        return True
