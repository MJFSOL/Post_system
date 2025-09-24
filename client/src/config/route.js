import {createRouter, createWebHistory} from 'vue-router'

import Home from '../components/home.vue'
import Signin from '../components/auth_user/signin.vue'
import Signup from '../components/auth_user/signup.vue'
import NotFound from '../components/auth_gates/NotFound.vue'


const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/signin', name: 'Signin', component: Signin },
  { path: '/signup', name: 'Signup', component: Signup },
  { path: '/:pathMatch(.*)*', name: 'NotFound', component: NotFound } // catch all
]


const router = createRouter({
  history: createWebHistory(), // normal URLs like /signin
  routes,
})


export default router
