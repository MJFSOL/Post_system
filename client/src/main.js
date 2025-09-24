import { createApp, h, provide } from 'vue'
import App from './App.vue'
import Router from './config/route.js'
import { DefaultApolloClient } from '@vue/apollo-composable'
import { apolloClient } from './apollo/apollo-client'  // make sure this exists

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient)
  },
  render: () => h(App),
})

// attach router
app.use(Router)

// mount app
app.mount('#app')
