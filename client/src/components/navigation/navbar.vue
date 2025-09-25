<script>
import { useRouter } from 'vue-router';
import authStore, { checkAuthStatus } from '../store/auth';

export default {
  setup() {
    const router = useRouter();

    const handleLogout = () => {
      localStorage.removeItem('authToken');
      checkAuthStatus();
      router.push('/signin');
    };

    return {
      authStore,
      handleLogout
    };
  },
};
</script>

<template>
  <template v-if="!authStore.isAuthenticated">
    <div class="guest-navbar">
      <div class="left-guest">
        <router-link to="/">Home</router-link>
      </div>
      <div class="right-guest">
        <router-link to="/signin">Sign In</router-link>
        <router-link to="/signup">Sign Up</router-link>
      </div>
    </div>
  </template>

  <template v-else>
    <div class="auth-sidebar">
      <div class="sidebar-links">
        <router-link to="/dashboard">Dashboard</router-link>
        <router-link to="/product_manager">Product Manager</router-link>
      </div>
      <div class="sidebar-logout">
        <a href="#" @click.prevent="handleLogout">Logout</a>
      </div>
    </div>
  </template>
</template>
<!-- <li><router-link to="/products_manager">Product Manager</router-link></li> -->