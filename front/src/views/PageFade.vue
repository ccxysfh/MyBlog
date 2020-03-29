<template>
  <nav class="pagination" role="pagination">
    <div class="inner">
      <div v-if="pageType==='tag'">
        <router-link v-if="pagecontrol.newerPage" class="pagination-next" :to="{ name: 'tagContent', params: { tag: tag, topage: pagecontrol.newerPage }}"><i class="ic ic-arrow-left"></i> <span class="pagination-label">Newer Posts</span></router-link>
        <span class="pagination-info">Page {{ pagecontrol.page }} of {{ pagecontrol.maxPage }}</span>
        <router-link v-if="pagecontrol.prev_page" class="pagination-prev" :to="{ name: 'tagContent', params: { tag: tag, topage: pagecontrol.prev_page }}"><span class="pagination-label">Older Posts</span> <i class="ic ic-arrow-right"></i></router-link>
        <div class="clear"></div>
      </div>
      <div v-else-if="pageType ==='index'">
        <router-link v-if="pagecontrol.newerPage" class="pagination-next" :to="{ name: 'pageRouter', params: { topage: pagecontrol.newerPage }}"><i class="ic ic-arrow-left"></i> <span class="pagination-label">Newer Posts</span></router-link>
        <span class="pagination-info">Page {{ pagecontrol.page }} of {{ pagecontrol.maxPage }}</span>
        <router-link v-if="pagecontrol.prev_page" class="pagination-prev" :to="{ name: 'pageRouter', params: { topage: pagecontrol.prev_page }}"><span class="pagination-label">Older Posts</span> <i class="ic ic-arrow-right"></i></router-link>
        <div class="clear"></div>
      </div>
      <div v-else>
        <router-link v-if="pagecontrol.newerPage" class="pagination-next" :to="{ name: 'profile', params: { topage: pagecontrol.newerPage }}"><i class="ic ic-arrow-left"></i> <span class="pagination-label">Newer Posts</span></router-link>
        <span class="pagination-info">Page {{ pagecontrol.page }} of {{ pagecontrol.maxPage }}</span>
        <router-link v-if="pagecontrol.prev_page" class="pagination-prev" :to="{ name: 'profile', params: { topage: pagecontrol.prev_page }}"><span class="pagination-label">Older Posts</span> <i class="ic ic-arrow-right"></i></router-link>
        <div class="clear"></div>
      </div>

    </div>
  </nav>
</template>

<script>
// '待完善，何时该显示此跳转栏，第一次加载时，文章前不显示，出现翻页后上下均显示'
// '出现单箭头，还是双箭头'
export default {
  name: 'page-fade',
  data () {
    return {
      baseUrl: this.$store.state.baseUrl
    }
  },
  props: {
    pagecontrol: {
      type: Object,
      required: true
    },
    tag: {
      type: String
    },
     pageType: {
      type: String,
      required: true
    }

  }
}
</script>

<style scoped>

</style>
