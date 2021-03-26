<template>
  <div class="tags-across">
    <div class="tag" v-for="tag in 10" :key="tag">
      {{ tag }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'TagsAcross'
}
</script>

<style scoped>
.tags-across {
  box-sizing: content-box;
  position: relative;
  width: calc(var(--ss) * 10 + 9px);
  height: var(--ss);
  display: grid;
  grid-template: 1fr / repeat(10, 1fr);
  grid-gap: 1px;
  border-left: 1px solid White;
  border-right: 1px solid White;
  background: White;
}
.top {
  border-top: 1px solid White;
}
.bottom {
  border-bottom: 1px solid White;
}
</style>
