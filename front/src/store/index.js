import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    blogpostsum: 0,
    baseUrl: 'https://changxin10m.com',
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
