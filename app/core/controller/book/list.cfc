component extends="taffy.core.resource" taffy_uri="/book/list" {

    bookService = new core.service.book();

    function get() {
        var books = bookService.getAll();

        if (arrayLen(books) == 0) {
            return rep([]).withStatus(200);
        }

        return rep(books).withStatus(200)
    }

}
