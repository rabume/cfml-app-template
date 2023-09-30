component extends="taffy.core.resource" taffy_uri="/book/create" {

    bookService = new core.service.book();

    function post(
        string title,
        string author,
        string isbn,
        string publisher,
        numeric pages
    ) {
        var books = bookService.create(
            arguments.title,
            arguments.author,
            arguments.isbn,
            arguments.publisher,
            arguments.pages
        );

        return rep(books).withStatus(200)
    }

}
