class Book {
	id: number | undefined
	title: string
	author: string
	isbn: string
	publisher: string
	pages: number | undefined

	constructor() {
		this.id = undefined
		this.title = ''
		this.author = ''
		this.isbn = ''
		this.publisher = ''
		this.pages = undefined
	}
}

export default Book
