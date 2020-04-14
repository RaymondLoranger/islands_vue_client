<template>
  <div id="guesses" :class="getFreezeCursor">
    <div class="square"
         :class="[getGuess(square), getFreezeEvents]"
         v-for="square in 100" :key="square"
         @click="hit(square)"/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Guesses',
  computed: mapGetters([
    'getChannel',
    'getFreezeCursor',
    'getFreezeEvents',
    'getGuess'
  ]),
  methods: {
    hit(square) {
      if (this.getGuess(square) === '') {
        this.getChannel.push('guess_coord', { square })
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
  width: calc(3vw * 10 + 9px);
  height: calc(3vw * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid White;
  background: White;
}
.square {
  background: SkyBlue;
}
.square:hover {
  background: PowderBlue;
  cursor: pointer;
}
.square.hit {
  background: ForestGreen;
  cursor: not-allowed;
}
.square.miss {
  background: DodgerBlue;
  cursor: not-allowed;
}
</style>
