<template>
  <div id="tags-down">
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
#tags-down {
  box-sizing: content-box;
  position: relative;
  width: 3vw;
  height: calc(3vw * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / 1fr;
  grid-gap: 1px;
  border: 1px solid White;
  background: White;
}
.tag {
  background: lightgray;
  text-align: center;
  vertical-align: middle;
  line-height: 3vw;
  font-weight: 600;
  font-size: 2vw;
}
</style>
