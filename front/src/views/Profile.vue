<template>
  <div>
    <header id="blog-header">
      <div class="inner ">
        <!--<slot name="headContent"></slot>-->
      </div>
    </header>
    <slot name="authorInfo"></slot>
    <all-blogposts :func="func">
    </all-blogposts>
  </div>
</template>

<script>
import authorInfo from './layout/components/AuthorInfo'
import allBlogposts from './AllBlogPosts'
export default {
  name: 'profile',
  components: {
    allBlogposts,
    authorInfo
  },
  data () {
    return {
      blogpostsnum: this.$store.state.blogpostsnum,
      func: 'profile'
    }
  },
  created () {
  },
  mounted () {
  },
  methods: {
  },
  watch: {
    '$route' (to, from) {
      // 对路由变化作出响应...
    }
  }
}
</script>

<style scoped>
  /*@import "../assets/css/gfm.css";*/

#blog-author .post-author {
  padding-bottom: 0em;
}
</style>
