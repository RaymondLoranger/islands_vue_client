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
  /* width: calc(50px * 10 + 9px);
  height: 50px; */
  width: calc(3vw * 10 + 9px);
  height: 3vw;
  display: grid;
  grid-template: 1fr / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid white;
  background: white;
}
.tag {
  background: lightgray;
  text-align: center;
  vertical-align: middle;
  /* line-height: 50px; */
  line-height: 3vw;
  font-weight: 600;
  /* font-size: 2em; */
  font-size: 2vw;
}
/* @media screen and (max-width: 1350px) {
  #tags-across {
    width: calc(40px * 10 + 9px);
    height: 40px;
  }
  .tag {
    line-height: 40px;
    font-size: 1.6em;
  }
}
@media screen and (max-width: 1100px) {
  #tags-across {
    width: calc(30px * 10 + 9px);
    height: 30px;
  }
  .tag {
    line-height: 30px;
    font-size: 1.4em;
  }
}
@media screen and (max-width: 850px) {
  #tags-across {
    width: calc(20px * 10 + 9px);
    height: 20px;
  }
  .tag {
    line-height: 20px;
    font-size: 1em;
  }
} */
</style>
