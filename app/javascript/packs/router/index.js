import Vue from "vue"
import VueRouter from "vue-router"

// Init VueRouter
Vue.use(VueRouter)

// Config the Router object
const router = new VueRouter({
  hashbang: false,
  mode: "history",
  // Register the routes
  routes: [
    {
      path: '/',
      redirect(to) {
        return {
          name: "usersIndex"
        }
      },
      name: 'Home',
      component: {
        template: '<router-view/>',
      }
    },
    {
      path: "/users",
      name: "usersIndex",
      component: () => import('../views/UsersIndex'),
      meta: {
      }
    }
  ]
})

export default router
