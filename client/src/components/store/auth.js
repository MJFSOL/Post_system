// store/auth.js
import { reactive, watch } from 'vue';

const authStore = reactive({
  isAuthenticated: false,
});

// A function to check auth status and update the store
export function checkAuthStatus() {
  const token = localStorage.getItem('authToken');
  authStore.isAuthenticated = !!token;
}

// Watch for changes in localStorage from other parts of the app
window.addEventListener('storage', () => {
  checkAuthStatus();
});

// Initial check when the app loads
checkAuthStatus();

export default authStore;