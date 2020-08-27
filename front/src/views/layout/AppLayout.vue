<template>
  <div>
    <nav-fade></nav-fade>

    <section id="wrapper">
      <div id="index" class="container">
        <main class="content" role="main">
          <nav id="navigation">
            <span class="blog-logo">
            </span>
            <span id="menu-button" class="nav-button">
              <a class="menu-button"><i class="ic ic-menu"></i> Menu</a>
            </span>
          </nav>

          <router-view>
            <div slot="headContent">
              <h1 class="blog-name"><a href="#">0823</a></h1>
              <span class="blog-description">{{motto}}</span>
              <span class="blog-description">——how you do anything is how you do everything</span>
            </div>
            <author-info slot="authorInfo"></author-info>
          </router-view>

          <footer id="footer">
<!--            邮件订阅或者点击右上角菜单RSS订阅-->
            <main-footer/>
          </footer>
        </main>
      </div>
      <footer />
    </section>
    <vm-back-top :duration="500"></vm-back-top>
    <remote-js src="//www.google-analytics.com/analytics.js"></remote-js>
  </div>

</template>

<script>
// config google analytic

import {NavFade, AuthorInfo, MainFooter} from './components'

import { mapState } from 'vuex'

export default {
  name: 'app-layout',
  components: {
    NavFade,
    AuthorInfo,
    MainFooter,
    'remote-js': {
      render(createElement) {
        return createElement('script', { attrs: { type: 'text/javascript', src: this.src }});
      },
      props: {
        src: { type: String, required: true },
      },
    },
  },
  data: function () {
    return {
      motto: this.$store.state.motto
    }
  },
  created() {
    console.log('AppLayout load');

  },
  mounted() {
    console.log('AppLayout mounted load script');
    this.renderGoogleAnalyse()
    // import('../../assets/js/script.js')
  },
  updated() {
    console.log('AppLayout updated load script');
    // import('../assets/js/script.js')
  },
  destroyed() {
    console.log('clear cache');
    this.$store.commit('assignAllBlogs', null);
    this.$store.commit('assignTagContent', null);
    this.$store.commit('assignArchive', {});
    this.$store.commit('assignBlogPost', {});
    this.$store.commit('assignShare', null);
  },
  methods: {
    renderGoogleAnalyse () {
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-112661341-1', 'auto');
        ga('send', 'pageview');
    }
  }
}
</script>

<style scoped>
</style>
