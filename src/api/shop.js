// import the http module that has been added by vue-resource
import Vue from 'vue'

/**
 * Mocking client-server processing
 */

// const _categories = [
//   {icon: 'bubble_chart', title: 'Category1', href: '/category/1'},
//   {icon: 'bubble_chart', title: 'Category2', href: '/category/2'},
//   {icon: 'bubble_chart', title: 'Category3', href: '/category/3'},
//   {icon: 'bubble_chart', title: 'Category4', href: '/category/4'}
// ]
// const _products = [
//   {
//     id: 1,
//     category: 1,
//     src: '/static/products/1.jpg',
//     name: 'Nanami',
//     desc: 'Nanami <3',
//     price: 1,
//     to: '/category/1/product/1'
//   },
//   {
//     id: 2,
//     category: 1,
//     src: '/static/products/2.jpg',
//     name: 'Touhou',
//     desc: 'touhou is great!',
//     price: 10,
//     to: '/category/1/product/2'
//   },
//   {
//     id: 3,
//     category: 1,
//     src: '/static/products/3.jpg',
//     name: 'Nanami 2',
//     desc: 'Nanami in full size',
//     price: 100,
//     to: '/category/1/product/3'
//   },
//   {
//     id: 4,
//     category: 1,
//     src: '/static/products/4.jpg',
//     name: 'Thinkink',
//     desc: 'Nanami thinking',
//     price: 1,
//     to: '/category/1/product/4'
//   },
//   {
//     id: 5,
//     category: 1,
//     src: '/static/products/5.jpg',
//     name: 'Portal',
//     desc: 'Portal  is great!',
//     price: 10,
//     to: '/category/1/product/5'
//   },
//   {
//     id: 6,
//     category: 1,
//     src: '/static/products/6.jpg',
//     name: 'Nanami 3',
//     desc: 'Nanami 3 in full size',
//     price: 100,
//     to: '/category/1/product/6'
//   }
// ]

export default {
  getProducts (cb) {
    Vue.http.get('products')
      .then((response) => {
        // console.log(response.body)
        cb(response.body)
      })
    // let temp = _products
    // temp = []
    // console.log(temp)
  },

  buyProducts (products, cb, errorCb) {
    setTimeout(() => {
      // simulate random checkout failure.
      (Math.random() > 0.5 || navigator.userAgent.indexOf('PhantomJS') > -1)
        ? cb()
        : errorCb()
    }, 100)
  },

  getCategories (cb) {
    Vue.http.get('categories')
      .then((response) => {
        // console.log(response.body)
        cb(response.body)
      })
    // let temp = _categories
    // temp = []
    // console.log(temp)
  }
}
