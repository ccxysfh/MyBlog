<template>
    <section id="blog-author" class="author-profile  away-top blog-author">
      <div class="inner" >
        <aside class="post-author">
          <figure class="post-author-avatar">
            <img src="../../../assets/images/ccx.jpeg" alt="Cheng,Changxin">
          </figure>
          <div id="infos">
            <span class="hidden">Changxin Cheng's Picture</span>
            <h1 class="author-title">Changxin Cheng</h1>
            <h2 class="author-bio"><p>Engineer at <a href="https://www.nio.cn" target="_blank" >NIO</a> form <a href="http://www.ustb.edu.cn/index.asp" target="_blank" >USTB</a>.</p><p>Find me on <a href="https://twitter.com/ChangXinCheng" target="_blank"><icon name="brands/twitter" scale="2" ></icon></a>, <a href="http://weibo.com/2935771467/profile?topnav=1&wvr=6" target="_blank" ><icon name="brands/weibo" scale="2" ></icon></a> or <a href="https://github.com/chengcx1019" target="_blank"><icon name="brands/github" scale="2" ></icon></a></p></h2>
            <div class="author-meta">
              <span class="author-location icon-location">Beijing</span>
              <span class="author-link icon-link"><a href="http://changxin10m.com">http://changxin10m.com</a></span>
              <span class="author-stats"><i class="icon-stats"></i> {{ blogpostsnum }} posts</span>
            </div>
          </div>
        </aside>
      </div>
    </section>
</template>

<script>

export default {
  components: {},
  name: 'author-info',
  computed: {
    blogpostsnum () {
      return this.$store.state.blogpostsum
    }
  }
}
</script>

<style scoped>
.inner,
  .pagination {
      width: auto;
      margin: 2rem auto;
  }
/*@import "../../../assets/css/screen.css";*/
/*@import "../../../assets/css/profile.css";*/

.author-meta {
    padding: 0;
    margin: 0;
    list-style: none;
    font-size: 1.4rem;
    line-height: 1;
    font-style: italic;
    color: #9EABB3;
}

.author-meta a {
    color: #9EABB3;
}
.author-meta a:hover {
    color: #111;
}
#infos {
  margin-top:100px;
}

.author-title {
    margin: 1.5rem 0 1rem;
    margin-top:120px;
}

.author-bio {
    font-size: 1.8rem;
    line-height: 1.5em;
    font-weight: 200;
    color: #50585D;
    letter-spacing: 0;
    text-indent: 0;
}

.author-meta {
    margin: 1.6rem 0;
}

/* Location, website, and link */
.author-profile .author-meta {
    margin: 2rem 0;
    font-family: "Merriweather", serif;
    letter-spacing: 0.01rem;
    font-size: 1.7rem;
}
.author-meta span {
    display: inline-block;
    margin: 0 2rem 1rem 0;
    word-wrap: break-word;
}
.author-meta a {
    text-decoration: none;
}

/* Turn off meta for page2+ to make room for extra
   pagination prev/next links */
.paged .author-profile .author-meta {
    display: block;
}
.post-author-avatar{
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  display: block;
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -60px;
  margin-top: -180px;
  width: 120px;
  height: 120px;
  border-radius: 100%;
  overflow: hidden;
  padding: 6px;
  background: #fff;
  z-index: 2;
  box-shadow: #E7EEF2 0 0 0 0px;
  margin-bottom: 50px;
}

.author-profile a:hover {
  color: #0b97c4;
}

img {
    border: 0;
}

.author-profile {
  padding: 0 15px 5rem 15px;
  border-bottom: #EBF2F6 1px solid;
  text-align: center;
}



/* Import the font file with the icons in it */
@font-face {
    font-family: "casper-icons";
    src:url("../../../assets/font/casper-icons.eot");
    src:url("../../../assets/font/casper-icons.eot") format("embedded-opentype"),
        url("../../../assets/font/casper-icons.woff") format("woff"),
        url("../../../assets/font/casper-icons.ttf") format("truetype"),
        url("../../../assets/font/casper-icons.svg") format("svg");
    font-weight: normal;
    font-style: normal;
}

/* Apply these base styles to all icons */
[class^="icon-"]:before, [class*=" icon-"]:before {
    font-family: "casper-icons", "Open Sans", sans-serif;
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    text-decoration: none !important;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

/* Each icon is created by inserting the correct character into the
   content of the :before pseudo element. Like a boss. */
.icon-ghost:before {
    content: "\f600";
}
.icon-feed:before {
    content: "\f601";
}
.icon-twitter:before {
    content: "\f602";
    font-size: 1.1em;
}
.icon-google-plus:before {
    content: "\f603";
}
.icon-facebook:before {
    content: "\f604";
}
.icon-arrow-left:before {
    content: "\f605";
}
.icon-stats:before {
    content: "\f606";
}
.icon-location:before {
    content: "\f607";
    margin-left: -3px; /* Tracking fix */
}
.icon-link:before {
    content: "\f608";
}
.icon-menu:before {
    content: "\f609";
}
/*
    IMPORTANT: When making any changes to the icon font, be sure to increment
    the version number by 1 in the @font-face rule. `?v=1` becomes `?v=2`
    This forces browsers to download the new font file.
*/

</style>
