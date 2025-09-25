<script setup>
import { gql } from '@apollo/client'
import { useMutation } from '@vue/apollo-composable'
import { ref } from 'vue'
import { useRouter } from 'vue-router' // Import the useRouter hook

const email = ref('')
const password = ref('')
const name = ref('');
const errors = ref([])

const router = useRouter() // Get the router instance

const SIGN_UP = gql`
  mutation SignUp($input: SignUpInput!) {
    signUp(input: $input) {
      user {
        id
        email
      }
      errors
    }
  }
`;

const { mutate: signUpMutation } = useMutation(SIGN_UP);

function signUp() {
  const input = {
    email: email.value,
    password: password.value,
    name: name.value
  };

  signUpMutation({ input }).then(res => {
    errors.value = res.data.signUp.errors;
    if (errors.value.length === 0) {
      router.push('/dashboard') // Redirect on successful sign-up
    }
  });
}
</script>

<template>
  <div class="signup-container">
    <div class="signup-box">
      <div class="signup-header">
        <h2>Create Account</h2>
      </div>
      <form @submit.prevent="signUp">
        <input v-model="name" placeholder="Name" />
        <input v-model="email" placeholder="Email" />
        <input v-model="password" type="password" placeholder="Password" />
        <button type="submit">Sign Up</button>
      </form>
      <p v-if="errors.length">{{ errors.join(', ') }}</p>
    </div>
  </div>
</template>