<template>
  <div id="guesses">
    <div class="square"
         :class="getGuess(square)"
         v-for="square in 100" :key="square"
         @click="hit(square, $event)"
         @mouseleave="mouseLeave(square, $event)"/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Guesses',
  computed: mapGetters(['getGuess', 'getChannel']),
  methods: {
    hit(square, e) {
      if (this.getGuess(square) === '') {
        this.getChannel.push('guess_coord', { square })
      }
    },
    // mouseOver(square, e) {
    //   if (!e.target.classList.contains('not-allowed')) {
    //     if (this.getGuess(square) !== '') {
    //       e.target.classList.add('not-allowed')
    //     }
    //   }
    //   const notAllowed = e.target.classList.contains('not-allowed')
    //   const notGuessed = this.getGuess(square) === ''
    //   if (notAllowed || notGuessed) {
    //     e.target.classList.add('allowed')
    //   } else {
    //     e.target.classList.add('not-allowed')
    //   }
    // }
    mouseLeave(square, e) {
      if (!e.target.classList.contains('not-allowed')) {
        if (this.getGuess(square) !== '') {
          e.target.classList.add('not-allowed')
        }
      }
    }
  }
}
</script>

<style scoped>
#guesses {
  /* pointer-events: none; */
  box-sizing: content-box;
  margin: 0 0;
  position: relative;
  width: calc(3vw * 10 + 9px);
  height: calc(3vw * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid white;
  background: white;
}
.square {
  background: SkyBlue;
}
.square:hover {
  background: PowderBlue;
  /* background: LightBlue; */
  cursor: pointer;
}
.square.not-allowed:hover {
  cursor: not-allowed;
}
.square.hit {
  background: ForestGreen;
  cursor: default;
}
/* .square.hit:hover {
  cursor: default;
} */
.square.miss {
  background: DodgerBlue;
  cursor: default;
}
/* .square.miss:hover {
  cursor: default;
} */
</style>
