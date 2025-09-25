// router/index.js (or wherever your router file is located)
import { createRouter, createWebHistory } from "vue-router";
import Home from "../components/home.vue";
import Signin from "../components/auth_user/signin.vue";
import Signup from "../components/auth_user/signup.vue";
import MerchantDashboard from "../components/merchant_pages/dashboard.vue";
import ProductManager from "../components/merchant_pages/productManager.vue";
import NotFound from "../components/auth_gates/NotFound.vue";

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/signin", name: "Signin", component: Signin },
  { path: "/signup", name: "Signup", component: Signup },
  {
    path: "/dashboard",
    name: "Dashboard",
    component: MerchantDashboard,
    meta: { requiresAuth: true }, // Mark this route as requiring authentication
  },
  {
    path: "/product_manager",
    name: "ProductManager",
    component: ProductManager,
    meta: { requiresAuth: true }, // Mark this route as requiring authentication
  },
  { path: "/:pathMatch(.*)*", name: "NotFound", component: NotFound },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

// Authentication Middleware
router.beforeEach((to, from, next) => {
  const isAuthenticated = localStorage.getItem("authToken");

  if (to.meta.requiresAuth && !isAuthenticated) {
    // If the route requires authentication and the user is not logged in, redirect them
    next("/signin");
  } else {
    // Otherwise, allow navigation
    next();
  }
});

export default router;
