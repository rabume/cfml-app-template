<template>
	<div>
		<p>Password</p>
		<input type="password" v-model="password" />
		<button @click="getAuthKey()">Enter</button>
	</div>
</template>

<style scoped lang="scss">
input[type='password'] {
	-webkit-text-security: disc;
}

div {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

p {
	margin-bottom: 10px;
}

input {
	width: 100px;
	margin-bottom: 10px;
}

button {
	width: 100px;
	height: 40px;
}
</style>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useAppStore } from '../stores/app'

// Stores
const appStore = useAppStore()

// Refs
const password = ref<string>('')

// Methods
const getAuthKey = () => {
	fetch(`${appStore.apiURL}/api/auth/token/${password.value}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json'
		}
	})
		.then((response) => response.json())
		.then((json) => {
			const { token } = json

			if (token) {
				localStorage.setItem('authKey', token)
				appStore.accessKey = token
			}
		})
}

// Hooks
onMounted(() => {
	const authKey = localStorage.getItem('authKey')

	if (authKey) {
		// Check if auth key jwt is expired
		const dateNow = new Date().getTime() / 1000
		const [, payload] = authKey.split('.')
		const { exp } = JSON.parse(atob(payload))

		if (dateNow > exp) {
			localStorage.removeItem('authKey')
			appStore.accessKey = ''
			return
		}

		appStore.accessKey = authKey
	}

	// Add event listener for enter key
	window.addEventListener('keydown', (event) => {
		if (event.key === 'Enter') {
			getAuthKey()
		}
	})
})

onUnmounted(() => {
	// Remove event listener for enter key
	window.removeEventListener('keydown', (event) => {
		if (event.key === 'Enter') {
			getAuthKey()
		}
	})
})
</script>
