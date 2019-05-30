// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'


import App from './App'
import router from './router'
import store from './store'

import VueResource from 'vue-resource'
import Icon from 'vue-awesome/components/Icon'

import VmBackTop from 'vue-multiple-back-top'


import './assets/css/style.css'

import './assets/js/script.js'

import 'vue-awesome/icons'
import * as filters from './filters' // global filters

Vue.config.productionTip = false
var vueFilter = require('vue-filter')

Vue.use(VueResource)
Vue.use(vueFilter)

Vue.component('icon', Icon)
Vue.component(VmBackTop.name, VmBackTop)

// register global utility filters.
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

Vue.config.devtools = true

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})




