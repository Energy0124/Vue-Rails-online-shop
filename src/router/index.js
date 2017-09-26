import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Category from '@/components/Category'
import Product from '@/components/Product'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Root',
      // redirect: '/category/1',
      component: Home,
      meta: {
        breadcrumb: 'Home'
      }
    }, {
      path: '/home',
      name: 'Home',
      // redirect: '/category/1',
      component: Home,
      meta: {
        breadcrumb: 'Home'
      }
    },
    {
      path: '/category/:categoryId',
      component: Category,
      meta: {
        breadcrumb: 'Category'
      }
    },
    {
      path: '/category/:categoryId/product/:productId',
      component: Product,
      meta: {
        breadcrumb: 'Product'
      }
    }
  ]
})
