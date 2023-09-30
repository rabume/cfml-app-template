<template>
	<h1>Books</h1>
	<div class="book-wrapper">
		<div v-if="books.length != 0" class="book" v-for="book in books" :key="book.id">
			<div class="book-content">
				{{ book.title }}
			</div>
			<button @click="deleteBook(book.id)">Delete</button>
		</div>

		<div class="add-book" @click="openModal" />
		<NewBookModal v-if="modalState" @update="closeModal" />
	</div>
</template>

<style scoped lang="scss">
.book-wrapper {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	max-width: 800px;
}

.book {
	display: flex;
	flex-direction: column;
	width: 125px;
	height: 200px;
	background-color: #454179;
	margin: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: all 0.2s ease-in-out;

	// no select
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

.book:hover {
	background-color: #5c5c9e;
	transform: scale(1.1);
}

.add-book {
	width: 125px;
	height: 200px;
	background-color: #454179;
	margin: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: all 0.2s ease-in-out;

	// no select
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;

	&:hover {
		background-color: #5c5c9e;
		transform: scale(1.1);
	}

	&::before {
		content: '+';
		font-size: 100px;
		color: #fff;
	}
}
</style>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useAppStore } from '../stores/app'

// Components
import NewBookModal from './BookNewModal.vue'

// Stores
const { accessKey, apiURL, validateKey } = useAppStore()

// Models
import Book from '../models/book'

// Refs
const books = ref<Book[]>([])
const modalState = ref<boolean>(false)

const deleteBook = (id: number | undefined) => {
	if (!id) return

	if (!accessKey) return

	fetch(`${apiURL}/api/book/delete/${id}`, {
		method: 'DELETE',
		headers: {
			Authorization: `Bearer ${accessKey}`
		}
	}).then((response) => {
		if (response.status === 204) getBooks()
	})
}

const getBooks = () => {
	validateKey()
	if (!accessKey) return

	fetch(`${apiURL}/api/book/list`, {
		headers: {
			Authorization: `Bearer ${accessKey}`
		}
	})
		.then((response) => response.json())
		.then((json) => (books.value = json))
}

const openModal = () => {
	modalState.value = true
}

const closeModal = () => {
	modalState.value = false
	getBooks()
}

// Hooks
onMounted(() => {
	getBooks()
})
</script>
