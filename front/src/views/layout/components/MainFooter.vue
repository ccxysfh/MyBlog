<template>
    <div class="inner">
      <section class="credits">
        <span class="credits-theme"><a href="/">Unity of Knowledge and Practice</a> &copy; 2017-{{year}}</span>
        <span class="credits-software">Published with <a href="http://ghost.org/">Ghost</a></span>
      </section>
    </div>
</template>

<script>
  export default {
    name: 'main-footer',
    computed: {
      year: function () {
        var date=new Date;
        var year=date.getFullYear();
        return year.toString()
      },
  }
  }
</script>

<style scoped>

</style>
