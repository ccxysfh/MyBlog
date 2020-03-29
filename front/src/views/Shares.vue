<template>
  <div>
    <header id="blog-header">
      <div class="inner ">
        <slot name="headContent"></slot>
      </div>
    </header>
    <article class="post">
      <div class="inner">
        <section class="post-excerpt">
          <span v-if='shares' v-html="shares.content "></span>
        </section>
      </div>
    </article>
  </div>

</template>

<script>
import appLayout from './layout/AppLayout'
var baseUrl = 'http://127.0.0.1:8000'
export default {
  name: 'shares',
  components: {
    appLayout
  },
  data () {
    return {
      shares: null
    }
  },
  methods: {
    async getShares () {
      let share = this.$store.state.share;
      if(share !=null){
        this.shares = share;
        console.log("load shares cache")
      }else{
        let reqUrl = this.$store.state.baseUrl + '/blog/api/shares';
        // console.log(reqUrl)
        await this.$http.get(reqUrl)
          .then((response) => {
            var res = JSON.parse(response.bodyText);
            this.shares = res.shares;
            this.$store.commit('assignShare', res.shares);
            console.log(res)
          })
      }
    }
  },
  created () {
    this.getShares()
  }
}
</script>

<style scoped>

</style>
