component name="bookRepository" {

    function getAll() {
        var books = entityLoad('Book');

        return books
    }

    function create(
        string title,
        string author,
        string isbn,
        string publisher,
        numeric pages
    ) {
        var book = new core.models.Book();

        book.setTitle(arguments.title);
        book.setAuthor(arguments.author);
        book.setIsbn(arguments.isbn);
        book.setPublisher(arguments.publisher);
        book.setPages(arguments.pages);

        entitySave(book)

        return book;
    }

    function get(numeric id) {
        var book = new core.models.Book();
        book = entityLoad('Book', arguments.id);

        return book;
    }

    function delete(Array book) {
        return entityDelete(arguments.book);
    }

}
