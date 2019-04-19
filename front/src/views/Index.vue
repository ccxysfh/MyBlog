<template>
  <!--#index，profile，tag都需要显示所有的blog-->
  <!--<h1 class="blog-name"><a href="changxin10m.com">知行合一</a></h1>-->
  <!--<span class="blog-description">求知笃行，珍惜所爱</span>-->
  <div>
    <header id="blog-header">
      <div class="inner ">
        <slot name="headContent"></slot>
      </div>
    </header>
    <!--<slot name="authorInfo"></slot>-->
    <all-blogposts :func="func"></all-blogposts>
  </div>
</template>

<script>
import allBlogposts from './AllBlogPosts'
import {mapState} from 'vuex'
export default {
  name: 'index',
  components: {
    allBlogposts
  },
  data: function(){
    return {
      func: 'index'
    }
  },
  mounted () {
  },
  updated() {
  },
  methods: {
  }
}
</script>

<style scoped>
</style>
