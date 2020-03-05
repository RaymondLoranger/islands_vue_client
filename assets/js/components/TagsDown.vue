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
  width: 50px;
  height: calc(50px * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / 1fr;
  grid-gap: 1px;
  border: 1px solid white;
  background: white;
}
.tag {
  background: lightgray;
  text-align: center;
  vertical-align: middle;
  line-height: 50px;
  font-weight: 600;
  font-size: 2em;
}
@media screen and (max-width: 1350px) {
  #tags-down {
    width: 40px;
    height: calc(40px * 10 + 9px);
  }
  .tag {
    line-height: 40px;
    font-size: 1.6em;
  }
}
@media screen and (max-width: 1100px) {
  #tags-down {
    width: 30px;
    height: calc(30px * 10 + 9px);
  }
  .tag {
    line-height: 30px;
    font-size: 1.4em;
  }
}
@media screen and (max-width: 850px) {
  #tags-down {
    width: 20px;
    height: calc(20px * 10 + 9px);
  }
  .tag {
    line-height: 20px;
    font-size: 1em;
  }
}
</style>
