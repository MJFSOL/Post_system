import { createApp, h, provide } from 'vue'
import App from './App.vue'
import Router from './config/route.js'
import './styles/navbar.css'
import './styles/style.css'
import './styles/productManager.css'
import './styles/dashboard.css'
import { DefaultApolloClient } from '@vue/apollo-composable'
import apolloClient from './apollo/apollo-client'


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
