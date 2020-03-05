<template>
  <div id="guesses">
    <div class="square" v-for="square in 100" :key="square" @click="hit"/>
  </div>
</template>

<script>
export default {
  name: 'Guesses',
  methods: {
    hit(e) {
      if (!e.target.classList.contains('hit')) {
        e.target.classList.add('hit')
      }
    }
  }
}
</script>

<style scoped>
#guesses {
  box-sizing: content-box;
  margin: 0 0;
  position: relative;
  width: calc(50px * 10 + 9px);
  height: calc(50px * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid white;
  background: white;
}
.square {
  background: SkyBlue;
}
.hit {
  background: ForestGreen;
}
@media screen and (max-width: 1350px) {
  #guesses {
    width: calc(40px * 10 + 9px);
    height: calc(40px * 10 + 9px);
  }
}
@media screen and (max-width: 1100px) {
  #guesses {
    width: calc(30px * 10 + 9px);
    height: calc(30px * 10 + 9px);
  }
}
@media screen and (max-width: 850px) {
  #guesses {
    width: calc(20px * 10 + 9px);
    height: calc(20px * 10 + 9px);
  }
}
</style>
