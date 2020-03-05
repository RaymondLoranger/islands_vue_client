<template>
  <div class="corner"/>
</template>

<script>
export default {
  name: 'Corner'
}
</script>

<style scoped>
.corner {
  box-sizing: content-box;
  background: lightgray;
  border: 1px solid white;
  width: 50px;
  height: 50px;
}
@media screen and (max-width: 1350px) {
  .corner {
    width: 40px;
    height: 40px;
  }
}
@media screen and (max-width: 1100px) {
  .corner {
    width: 30px;
    height: 30px;
  }
}
@media screen and (max-width: 850px) {
  .corner {
    width: 20px;
    height: 20px;
  }
}
</style>
