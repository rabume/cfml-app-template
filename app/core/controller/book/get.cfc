component extends="taffy.core.resource" taffy_uri="/book/{id}" {

    bookService = new core.service.book();

    function get(numeric id) {
        var book = bookService.get(arguments.id);

        return rep(book).withStatus(200)
    }

}
