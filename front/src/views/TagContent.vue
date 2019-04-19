<template>
  <div>
    <header id="blog-header">
      <div class="inner ">

        <h1 class="blog-name">
          <router-link :to="{ name: 'tagContent', params: { tag: tag }}">{{ tag }}</router-link>
        </h1>
      </div>
    </header>

    <all-blogposts :func="func" :key="refresh"></all-blogposts>
  </div>

</template>

<script>
import allBlogposts from './AllBlogPosts'
export default {
  name: 'tag-content',
  components: {
    allBlogposts
  },
  data () {
    return {
      func: 'tag',
      tag: '',
      refresh: true
    }
  },
  created () {
    if (this.$route.params.tag) {
      let tag = this.$route.params.tag
      this.tag = tag
      console.log(tag)
    }
  },
  watch: {
    '$route' (to, from) {
      if (this.$route.params.tag) {
        let tag = this.$route.params.tag
        this.tag = tag
        console.log('tag in tagContent:' + tag)
        this.refresh = !this.refresh
      }
    }
  }
}
</script>

<style scoped>
</style>
