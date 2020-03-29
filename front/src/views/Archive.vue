<template>
      <div>
        <article class="post tag-postgres" v-for="category in categoryPosts" :key="category[0]">
          <div class="inner">
          <div id="category">

            <h1 class="entry-title">

              <span v-if="category[0] == 'programming'">Programming</span>
              <span v-else-if="category[0] == 'ml'">Machine Learning</span>
              <span v-else-if="category[0] == 'su'">Summary</span>
              <span v-else-if="category[0] == 'ani'">Animation</span>
              <span v-else>Others</span>
            </h1>
          </div>
          <div id="blog-archives">
            <div v-for="yearPosts in category[1]" :key="yearPosts[0]">
              <h2>{{ yearPosts[0] }}</h2>
              <article v-for="blogpost in yearPosts[1]" :key="blogpost.pk">
                <h1 >
                  <router-link :to="{ name: 'postDetail', params: {url : blogpost.url}}" v-text="blogpost.fields.title"></router-link>
                </h1>

                <footer>
                  <span class="tags">
                    posted in
                    <tag-item
                     v-for="tag in blogpost.tags"
                     v-bind:key = "tag.pk"
                     v-bind:tag = "tag"
                    />
                  </span>|
                  <time :datetime="blogpost.fields.pub_date" class='.post-date'>
                    <span class="month" v-text="$options.filters.date(blogpost.fields.pub_date, '%b')"></span>
                    <span class="day" v-text="$options.filters.date(blogpost.fields.pub_date, '%d')"></span>
                  </time>
                </footer>
              </article>
            </div>
          </div>
          </div>
        </article>
      </div>
</template>

<script>
  import tagItem from './TagItem'
  import appLayout from './layout/AppLayout'

  export default {
  name: 'archive',
  components: {
    appLayout,
    tagItem
  },
  data () {
    return {
      categoryPosts: null
    }
  },
  methods: {
    async blogArchive () {
      let archiveCache = this.$store.state.archive;
      if (archiveCache !=null){
        console.log("load archive cache");
        this.categoryPosts = archiveCache.data;
      }else{
        let reqUrl = this.$store.state.baseUrl + '/blog/api/archive';
        await this.$http.get(reqUrl)
          .then((response) => {
            var res = JSON.parse(response.bodyText);
            console.log(res);
            this.$store.commit('assignArchive', res);
            this.categoryPosts = res.data
          })
      }

    }
  },
  mounted () {
    this.blogArchive()
  },
  updated() {
  }
}
</script>

<style scoped>
/*@import '../assets/css/screen.css';*/
@import '../assets/css/archive.css';
.post {
    position: relative;
    width: 80%;
    max-width: 710px;
    margin: 4rem auto;
    padding-bottom: 4rem;
    border-bottom: #EBF2F6 1px solid;
    word-wrap: break-word;
}

#blog-archive .post-date {
    display: inline-block;
    margin-left: 8px;
    padding-left: 12px;
    border-left: #d5dbde 1px solid;
    text-transform: uppercase;
    font-size: 1.3rem;
    white-space: nowrap;
}
</style>
