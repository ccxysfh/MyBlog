<template>
  <article class="post">
    <div class="inner">
      <p class="meta">
        <time :pubdate="blogpost.fields.pub_date" >{{$options.filters.date(blogpost.fields.pub_date, '%w')| toWeekDay}},</time>
        <time :pubdate="blogpost.fields.pub_date" :data-updated="blogpost.fields.last_edit_date"
              v-text="$options.filters.date(blogpost.fields.pub_date, '%b')+' '+
              $options.filters.date(blogpost.fields.pub_date, '%d')+ ','+
              $options.filters.date(blogpost.fields.pub_date, '%Y') + ' at '+
              $options.filters.date(blogpost.fields.pub_date, '%T')"
        >
        </time>
      </p>
      <header class="post-header">
        <h2 class="post-title"><router-link :to="{ name: 'postDetail', params: {url : blogpost.url}}">{{ blogpost.fields.title }}</router-link></h2>
        <div class="clear"></div>
      </header>

      <section class="post-excerpt">
        <span v-html="blogpost.content"></span>
      </section>
      <footer class="post-meta">
        <img class="author-thumb" src="../assets/images/ccx.jpeg" alt="Changxin Cheng" nopin="nopin" />
        <router-link :to="{ name: 'profile'}">Changxin Cheng</router-link>
        posted in
        <tag-item
         v-for="tag in blogpost.tags"
         v-bind:key = "tag.pk"
         v-bind:tag = "tag"
        />
        <time class="post-date" :pubdate="blogpost.fields.pub_date" :data-updated="blogpost.fields.last_edit_date" v-text="$options.filters.date(blogpost.fields.pub_date, '%b') +' '+$options.filters.date(blogpost.fields.pub_date, '%d')+ ','+ $options.filters.date(blogpost.fields.pub_date, '%Y') ">
        </time>
      </footer>
    </div>
  </article>
</template>

<script>
  import tagItem from './TagItem'
  export default {
  name: 'blog-post',
  components: {
    tagItem
  },
  data () {
    return {
    }
  },
  props: {
    blogpost: {
      type: Object,
      // required: false
      required: true
    }
  },
  methods: {
    reRender() {
      if(window.MathJax) {
        console.log('rendering mathjax');
        window.MathJax.Hub.Queue(["Typeset", window.MathJax.Hub], () => console.log('done'));
      }
    },
    uml(){
      $("code").each(function() {
        var uml_index = $(this).text().indexOf("@startuml")
        if(uml_index>-1){
          var src = "//www.plantuml.com/plantuml/img/" + window.plantumlEncoder.encode( $(this).text() )
          $(this).replaceWith($('<img>').attr('src', src));
        }
      });
    }

  },
  watch: {
    blogpost: function() {
      console.log('blogpost changed')
      this.reRender();
    }
  },
  mounted() {
    this.reRender()
    this.uml()
  },
}
</script>

<style scoped>
  .post-header {
    margin-bottom: 25px;
  }

  .author-thumb {
    width: 24px;
    height: 24px;
    float: left;
    margin: auto;
    padding: 3px;
    border-radius: 100%;
    margin-top: -5px;
  }

  .post-date {
    display: inline-block;
    margin-left: 8px;
    padding-left: 12px;
    border-left: #d5dbde 1px solid;
    text-transform: uppercase;
    font-size: 1.3rem;
    white-space: nowrap;
  }

  .post-title h2 {
  font-size: 2.0em;
  }

  .post-excerpt {
  font-size: 0.8em;
  }

  .container .post {
  padding: 1.5em 0;
  }

  .post-meta {
  margin: 1.334em 0;
  }


</style>
