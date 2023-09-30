import { defineStore } from 'pinia'
import { ref } from 'vue'

// Constants
const accessKey = ref<string>('')

const apiURL = import.meta.env.VITE_API_URL

const validateKey = () => {
	const authKey = localStorage.getItem('authKey')

	if (authKey) {
		// Check if auth key jwt is expired
		const dateNow = new Date().getTime() / 1000
		const [, payload] = authKey.split('.')
		const { exp } = JSON.parse(atob(payload))

		if (dateNow > exp) {
			localStorage.removeItem('authKey')
			accessKey.value = ''
			return
		}

		accessKey.value = authKey
	}
}

export const useAppStore = defineStore('app', () => {
	return {
		validateKey,
		accessKey,
		apiURL
	}
})
