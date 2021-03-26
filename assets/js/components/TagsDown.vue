<template>
  <div class="tags-down">
    <div class="tag" v-for="tag in 10" :key="tag">
      {{ tag }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'TagsDown'
}
</script>

<style scoped>
.tags-down {
  box-sizing: content-box;
  position: relative;
  width: var(--ss);
  height: calc(var(--ss) * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / 1fr;
  grid-gap: 1px;
  border-top: 1px solid White;
  border-bottom: 1px solid White;
  background: White;
}
.left {
  border-left: 1px solid White;
}
.right {
  border-right: 1px solid White;
}
</style>
