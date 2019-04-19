<template>
  <span>
    <router-link :to="{ name: 'tagContent', params: { tag: tag.fields.name }}">{{ tag.fields.name }}</router-link>,
  </span>
</template>

<script>
export default {
  name: 'tag-item',
  props: {
    tag: {
      type: Object,
      required: true
    }
  }
}
</script>

<style scoped>

</style>
