<template>
	<BookOverview v-if="appStore.accessKey !== ''" />
	<SimpleAuth v-else />
</template>

<script setup lang="ts">
import { useAppStore } from './stores/app'

// Store
const appStore = useAppStore()

// Components
import BookOverview from './components/BookOverview.vue'
import SimpleAuth from './components/SimpleAuth.vue'
</script>
