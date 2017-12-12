// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import Vuetify from 'vuetify'
import './stylus/main.styl'
import App from './App'
import router from './router'
import VueBreadcrumbs from 'vue-breadcrumbs'
import store from './store'
import VueResource from 'vue-resource'
import VeeValidate from 'vee-validate'
import VueCookie from 'vue-cookie'
import VueLocalStorage from 'vue-localstorage'
import vueConfig from 'vue-config'
// Tell Vue to use the plugin
Vue.use(VueCookie)
Vue.use(Vuetify)
Vue.use(VueResource)
Vue.use(VueBreadcrumbs)
Vue.use(VeeValidate)
Vue.use(VueLocalStorage)

// const vueConfig = require('vue-config')
// const configs = {
//   IMAGE_ROOT: 'http://localhost:3000' // It's better to require a config file
// }
const configs = {
  IMAGE_ROOT: 'http://52.42.184.70:3000' // It's better to require a config file

}

// Object.defineProperties(Vue.prototype, {
//   $config: {
//     get: function () {
//       return configs
//     }
//   }
// })

Vue.use(vueConfig, configs)

Vue.config.productionTip = false

// set the API root so we can use relative url's in our actions.

if (process.env.NODE_ENV === 'development') {
  Vue.http.options.root = 'http://localhost:3000'
  window.apiRoot = 'http://localhost:3000/'
} else {
  Vue.http.options.root = 'https://s11.ierg4210.ie.cuhk.edu.hk/api/'
  window.apiRoot = 'https://s11.ierg4210.ie.cuhk.edu.hk/api/'
}

const EventBus = new Vue()

Object.defineProperties(Vue.prototype, {
  $bus: {
    get: function () {
      return EventBus
    }
  }
})
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: {App}
})
