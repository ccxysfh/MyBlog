<template>
  <nav id="menu">
    <a class="close-button">Close</a>
    <div class="nav-wrapper">
      <p class="nav-label">Menu</p>
      <ul>
        <li class="nav-home" role="presentation"><router-link :to="{ name : 'index'}">Home</router-link></li>
        <li class="nav-archive" role="presentation"><router-link :to="{ name : 'archive'}">Archive</router-link></li>
        <li class="nav-shares" role="presentation"><router-link :to="{ name : 'shares'}">Shares</router-link></li>
        <!--<li class="nav-tags" role="presentation"><router-link :to="{ name : 'tag'}">Tags</router-link></li>-->
        <li class="nav-profile" role="presentation"><router-link :to="{ name: 'profile'}">profile</router-link></li>
        <li class="nav-feed" role="presentation"><a :href="siteurl+'/blog/feed'" target="_blank"><icon name="rss" scale="1" ></icon>subscribe</a></li>
      </ul>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'nav-fade',
  mounted () {

  },
  computed: {
    siteurl: function () {
      return this.$store.state.baseUrl
    }
  },
  updated() {

  }
}
</script>

<style scoped>

</style>
