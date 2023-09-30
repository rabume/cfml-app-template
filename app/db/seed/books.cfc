component {

    function run(qb, mockData) {
        var testBooks = arguments.mockData.mock(
            argumentCollection = {
                '$num': 14,
                'title': 'name',
                'author': 'name',
                'isbn': 'string',
                'publisher': 'name',
                'pages': 'num'
            }
        );

        arguments.qb.table('books').insert(testBooks);
    }

}
