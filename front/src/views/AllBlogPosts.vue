<template>
    <div>
      <page-fade v-if="pageControl.showFront" :pagecontrol="pageControl" :tag="tag" :key="refresh"></page-fade>
      <blogpostpanel
        v-for="blog in bloglistSlice"
        v-bind:key="blog.pk"
        :blogpost="blog"/>
      <page-fade :pagecontrol="pageControl" :tag="tag"></page-fade>
    </div>
</template>

<script>
  import blogpostpanel from './BlogPost'
  import pageFade from './PageFade'

  export default {
  name: 'all-blog-posts',
  components: {
    blogpostpanel,
    pageFade
  },
  props: {
    func: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      pageControl: {
        page: 0,
        maxPage: 1,
        showFront: false,
        sl: '',
        newerPage: null,
        prev_page: null
      },
      blogpostsnum: 0,
      blogList: [],
      tag: null,
      refresh: 1
    }
  },
  created () {
    this.updateContent()
  },
  mounted () {
  },
  methods: {
    showdata () {
      console.log(this.pagecontrol)
    },
    updateContent () {
      var page = 1
      // console.log(Number(this.$route.params.topage))
      if (this.$route.params.topage) {
        page = Number(this.$route.params.topage)
        // console.log(page)
      }
      if (this.func === 'index') {
        // console.log('index')
        this.allBlogPosts(page)
      } else if (this.func === 'tag') {
        if (this.$route.params.tag) {
          let tag = this.$route.params.tag
          this.tag = tag
          console.log('tag')
          this.tagBlogPosts(tag, page)
          // this.$emit('update:foo', tag) // mean what
        }
      }
    },
    initControl (res) {
      this.blogList = res.blogposts
      // this.blogpostsnum = res.blogpostsnum
      this.$store.commit('assignment', res.blogpostsnum)
      this.pageControl.maxPage = res.max_page
      this.pageControl.page = res.page
      this.pageControl.sl = res.sl
      this.pageControl.newerPage = res.newer_page
      this.pageControl.prev_page = res.prev_page
      if (this.pageControl.page > 1) {
        this.pageControl.showFront = true
      } else {
        this.pageControl.showFront = false
      }
    },
    allBlogPosts (page) {
      let reqUrl = this.$store.state.baseUrl + '/blog/api/allblogs/' + page
      // console.log(reqUrl)
      this.$http.get(reqUrl)
        .then((response) => {
          var res = JSON.parse(response.bodyText)
          // console.log(res)
          this.initControl(res)
        })
    },
    tagBlogPosts (tag, page) {
      console.log('tag in tagBlogPosts:' + tag)
      let reqUrl = this.$store.state.baseUrl + '/blog/api/tag/' + tag + ',' + page
      console.log(reqUrl)
      this.$http.get(reqUrl)
        .then((response) => {
          var res = JSON.parse(response.bodyText)
          // console.log(res)
          this.initControl(res)
        })
    }
  },
  watch: {
    '$route' (to, from) {
      this.updateContent()
      this.refresh = !this.refresh
      console.log(this.refresh)
      // this.reload()
    }
  },
  computed: {
    bloglistSlice: function () {
      var slices = this.pageControl.sl.split(':')
      // console.log(slices)
      var start = parseInt(slices[0])
      var end = parseInt(slices[1])
      return this.blogList.filter(function(item, index) {
        return index >= start && index < end;
      })
    },
  }
}
</script>

<style scoped>
</style>
