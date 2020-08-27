<template>
    <div>
      <page-fade v-if="pageControl.showFront" :pagecontrol="pageControl" :tag="tag" :pageType="pageType" :key="refresh"></page-fade>
      <blogpostpanel
        v-for="blog in bloglistSlice"
        v-bind:key="blog.pk"
        :blogpost="blog"/>
      <page-fade :pagecontrol="pageControl" :tag="tag" :pageType="pageType"></page-fade>
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
      pageType:null,
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
      this.pageType = this.func;
      var page = 1;
      // console.log(Number(this.$route.params.topage))
      if (this.$route.params.topage) {
        page = Number(this.$route.params.topage)
        // console.log(page)
      }
      if (this.func === 'index' || this.func === 'profile') {
        // console.log('index')
        this.allBlogPosts(page)
      } else if (this.func === 'tag') {
        if (this.$route.params.tag) {
          let tag = this.$route.params.tag
          this.tag = tag
          console.log('load tag page')
          this.tagBlogPosts(tag, page)
          // this.$emit('update:foo', tag) // mean what
        }
      }
    },
    initControl (res) {
      this.blogList = res.blogposts;
      if (this.func === 'index'){
        this.$store.commit('assignment', res.blogpostsnum)
      }

      this.pageControl.maxPage = res.max_page;
      this.pageControl.page = res.page;
      this.pageControl.sl = res.sl;
      this.pageControl.newerPage = res.newer_page;
      this.pageControl.prev_page = res.prev_page;
      this.pageControl.showFront = this.pageControl.page > 1;
    },
    async allBlogPosts (page) {
      let allBlogCache = this.$store.state.allBlogs;
      if(allBlogCache != null){
        var blogsSplitByPage = this.splitByPage(allBlogCache, page);
        this.initControl(blogsSplitByPage);
        console.log("find all blogs cache");
      }else{
        const start = Date.now();
        let reqUrl = this.$store.state.baseUrl + '/blog/api/allblogs/' + page;
        await this.$http.get(reqUrl)
          .then((response) => {
            const millis = Date.now() - start;
            console.log(`seconds elapsed = ${Math.floor(millis / 1000)}`);
            var res = JSON.parse(response.bodyText);
            console.log("get all");
            this.$store.commit('assignAllBlogs', res);
            this.initControl(res)
          })
      }

    },
    async tagBlogPosts (tag, page) {
      let tagContentCache = this.$store.state.tagContent;
      if(tag in tagContentCache){
        var tagBlogsSplitByPage = this.splitByPage(tagContentCache[tag],page)
        this.initControl(tagBlogsSplitByPage);
        console.log("find tag blogs cache");
      }else{
        console.log('tag in tagBlogPosts:' + tag);
        let reqUrl = this.$store.state.baseUrl + '/blog/api/tag/' + tag + ',' + page
        console.log(reqUrl);
        await this.$http.get(reqUrl)
          .then((response) => {
            var res = JSON.parse(response.bodyText);
            tagContentCache[tag] = res;
            this.$store.commit('assignTagContent', tagContentCache);
            this.initControl(res)
          })
      }

    },
    splitByPage(res, page){
      res.page=page;
      res.sl=String(3 * (page - 1)) + ':' + String(3 * (page - 1) + 3);
      res.newer_page=page > 1 ? page - 1 : NaN;
      res.prev_page= page<res.max_page ? page+1 :NaN;
      console.log(res);
      return res
    }
  },
  watch: {
    '$route' (to, from) {
      this.updateContent();
      this.refresh = !this.refresh;
      console.log(this.refresh)
    }
  },
  computed: {
    bloglistSlice: function () {
      var slices = this.pageControl.sl.split(':');
      var start = parseInt(slices[0]);
      var end = parseInt(slices[1]);
      return this.blogList.filter(function(item, index) {
        return index >= start && index < end;
      })
    },
  }
}
</script>

<style scoped>
</style>
