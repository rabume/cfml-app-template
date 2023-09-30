component {

    function up() {
        queryExecute('
			CREATE TABLE books (
				id SERIAL PRIMARY KEY,
				title VARCHAR(255) NOT NULL,
				author VARCHAR(255) NOT NULL,
				isbn VARCHAR(255) NOT NULL,
				publisher VARCHAR(255) NOT NULL,
				pages INTEGER NOT NULL
			);
        ');
    }

    function down() {
        queryExecute('
            DROP TABLE books
        ');
    }

}
