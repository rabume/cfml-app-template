component extends="taffy.core.resource" taffy_uri="/book/delete/{id}" {

    bookService = new core.service.book();

    function delete(numeric id) {
        var book = bookService.delete(arguments.id);

        // If book is not defined the book got deleted
        if (isNull(book)) {
            return noData().withStatus(204, 'Book deleted!');
        }

        return rep(book).withStatus(400);
    }

}
