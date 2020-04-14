<template>
  <div id="tags-across">
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
#tags-across {
  box-sizing: content-box;
  position: relative;
  width: calc(3vw * 10 + 9px);
  height: 3vw;
  display: grid;
  grid-template: 1fr / repeat(10, 1fr);
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
