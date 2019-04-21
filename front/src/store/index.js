import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    blogpostsum: 0,
    baseUrl: 'http://127.0.0.1:80',
    motto: '',
  },
  mutations: {
    assignment (state, postblogsum) {
      state.blogpostsum = postblogsum
    },
    assignBaseUrl (state, url) {
      state.baseUrl = url
    }
  }
})

export default store
