<template>
	<div class="new-book-modal">
		<label for="title">Title</label>
		<input v-model="newBookForm.title" />

		<label for="author">Author</label>
		<input v-model="newBookForm.author" />

		<label for="isbn">ISBN</label>
		<input v-model="newBookForm.isbn" />

		<label for="publisher">Publisher</label>
		<input v-model="newBookForm.publisher" />

		<label for="pages">Pages</label>
		<input v-model="newBookForm.pages" type="number" />
		<button @click="addBook()">Add</button>
	</div>
</template>

<style scoped lang="scss">
.new-book-modal {
	display: flex;
	position: fixed;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	flex-direction: column;

	input {
		width: 200px;
		height: 30px;
		margin-bottom: 10px;
	}

	button {
		width: 100px;
		height: 30px;
	}
}
</style>

<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue'
import { useAppStore } from '../stores/app'

// Models
import Book from '../models/book'

// Stores
const { accessKey, apiURL } = useAppStore()

// Emits
const emits = defineEmits(['update'])

// Reactive
const newBookForm = ref<Book>({
	id: undefined,
	title: '',
	author: '',
	isbn: '',
	publisher: '',
	pages: undefined
})

// Methods
const addBook = () => {
	const newBook: Book = {
		id: undefined,
		title: newBookForm.value.title,
		author: newBookForm.value.author,
		isbn: newBookForm.value.isbn,
		publisher: newBookForm.value.publisher,
		pages: newBookForm.value.pages
	}

	fetch(`${apiURL}/api/book/create`, {
		method: 'POST',
		headers: {
			Authorization: `Bearer ${accessKey}`,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(newBook)
	}).then((response) => {
		if (response.status === 200) {
			emits('update')
		}
	})

	// Clear form
	newBookForm.value.title = ''
	newBookForm.value.author = ''
	newBookForm.value.isbn = ''
	newBookForm.value.publisher = ''
	newBookForm.value.pages = undefined
}

// Hooks
onMounted(() => {
	// Add event listener for enter key
	window.addEventListener('keydown', (event) => {
		if (event.key === 'Enter') {
			addBook()
		}
	})
})

onUnmounted(() => {
	// Remove event listener for enter key
	window.removeEventListener('keydown', (event) => {
		if (event.key === 'Enter') {
			addBook()
		}
	})
})
</script>
