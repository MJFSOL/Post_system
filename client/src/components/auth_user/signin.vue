<script setup>
import { gql } from '@apollo/client'
import { useMutation } from '@vue/apollo-composable'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { checkAuthStatus } from '../store/auth.js'; // Import the function

const email = ref('')
const password = ref('')
const errors = ref([])

const router = useRouter()

const SIGN_IN = gql`
  mutation SignIn($input: SignInInput!) {
    signIn(input: $input) {
      token
      user {
        id
        email
      }
      errors
    }
  }
`;

const { mutate: signInMutation } = useMutation(SIGN_IN)

function signIn() {
  // Create an input object to hold the variables
  const input = {
    email: email.value,
    password: password.value,
  };

  // Pass the input object to the mutation
  signInMutation({ input }).then(res => {
    if (res.data.signIn.errors.length > 0) {
      errors.value = res.data.signIn.errors;
    } else {
      const token = res.data.signIn.token;
      localStorage.setItem('authToken', token);
      
      // Update the global state after setting the token
      checkAuthStatus(); 
      
      router.push('/dashboard');
    }
  }).catch(e => {
    errors.value = ["An unexpected error occurred. Please try again."];
  });
}
</script>

<template>
  <div class="signin-container">
    <div class="signin-box">
      <div class="signin-header">
        <h2>Sign In</h2>
      </div>
      <form @submit.prevent="signIn">
        <input v-model="email" placeholder="Email" />
        <input v-model="password" type="password" placeholder="Password" />
        <button type="submit">Sign In</button>
      </form>
      <p v-if="errors.length">{{ errors.join(', ') }}</p>
    </div>
  </div>
</template>