import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    blogpostsum: 0,
    baseUrl: 'https://changxin10m.cn',
    motto: '',
    allBlogs:null,
    tagContent:{},
    blogPost:{},
    archive:null,
    share:null
  },
  mutations: {
    assignment (state, postblogsum) {
      state.blogpostsum = postblogsum
    },
    assignBaseUrl (state, url) {
      state.baseUrl = url
    },
    assignAllBlogs(state, allBlogs){
      state.allBlogs=allBlogs
    },
    assignTagContent(state, content){
      state.tagContent= content
    },
    assignArchive(state, archive){
      state.archive= archive
    },
    assignShare(state, share){
      state.share= share
    },
    assignBlogPost(state, blogPost){
      state.blogPost = blogPost;
       window.localStorage.setItem('blogPost',JSON.stringify(blogPost));
    }
  }
});

export default store
