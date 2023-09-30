component name="bookService" {

    bookRepository = new core.repository.book();

    function getAll() {
        return bookRepository.getAll()
    }

    function create(
        string title,
        string author,
        string isbn,
        string publisher,
        numeric pages
    ) {
        return bookRepository.create(
            arguments.title,
            arguments.author,
            arguments.isbn,
            arguments.publisher,
            arguments.pages
        )
    }

    function get(numeric id) {
        var book = bookRepository.get(arguments.id)

        if (arrayIsEmpty(book)) {
            return 'Book with this ID was not found'
        }

        return book
    }

    function delete(numeric id) {
        var bookToDelete = bookRepository.get(arguments.id)

        if (arrayIsEmpty(bookToDelete)) {
            return 'Book with this ID was not found'
        }

        return bookRepository.delete(bookToDelete)
    }

}
