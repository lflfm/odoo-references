from odoo.tests.common import TransactionCase, tagged

# from .helper_logger_mock import MockLogger
# from .helper_xmlrpc_mock import MockXmlrpc


@tagged("rising_systems")
class TestBook(TransactionCase):
    # def setUp(self, *args, **kwargs):
    #     super().setUp(*args, **kwargs)

    def test_book_create_active(self):
        "New Books are active by default"
        # arrange
        book = self.env["library.book"]
        # act
        book1 = book.create({
            "name": "Odoo Development Essentials",
            "isbn": "879-1-78439-279-6"})
        # assert
        self.assertEqual(
            book1.active, True
        )

    def test_book_create_admin(self):
        "admin user can create books"
        # arrange
        user_admin = self.env.ref("base.user_admin")
        admin_env = self.env(user=user_admin)
        book = admin_env["library.book"]
        # act
        book1 = book.create({
            "name": "Odoo Development Essentials",
            "isbn": "879-1-78439-279-6"})
        # assert
        self.assertEqual(
            book1.active, True
        )

    def test_check_isbn(self):
        "Check valid ISBN"
        # arrange
        book = self.env["library.book"]
        # act
        book1 = book.create({
            "name": "Odoo Development Essentials",
            "isbn": "879-1-78439-279-6"})
        # assert
        self.assertTrue(book1.button_check_isbn(), "ISBN should be valid")
