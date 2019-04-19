<template>
  <div>
    <header id="blog-header">
      <div class="inner ">
        <nav id="navigation">
          <span class="blog-logo">
          </span>
        </nav>
      </div>
    </header>

    <blogpostpanel :blogpost="blogpost">
    </blogpostpanel>
    <div class="inner">
      <div  id="disqus_thread"></div>
    </div>

  </div>
</template>

<script>
import blogpostpanel from './BlogPost'
export default {
  name: 'post-detail',
  components: {
    blogpostpanel
  },
  data() {
    return {
      blogpost: null
    }
  },
  computed: {},
  beforeCreate() {

  },
  created () {
    this.getBlogPost()
    this.disque()
  },
  methods: {
    getBlogPost () {
      let url = this.$route.params.url
      let reqUrl = this.$store.state.baseUrl + url
      console.log(reqUrl)
      let self = this
      this.$http.get(reqUrl)
        .then((response) => {
          var res = JSON.parse(response.bodyText)
          self.blogpost = res.blogpost
          console.log(self.blogpost)
        })
    },
    disque () {
      /**
      *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
      *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
      /*
      var disqus_config = function () {
      this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
      this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
      };
      */
      (function() { // DON'T EDIT BELOW THIS LINE
      var d = document, s = d.createElement('script');
      s.src = 'https://unity-of-knowledge-and-practice.disqus.com/embed.js';
      s.setAttribute('data-timestamp', +new Date());
      (d.head || d.body).appendChild(s);
      })();
    }
  }
}
</script>

<style scoped>

</style>
