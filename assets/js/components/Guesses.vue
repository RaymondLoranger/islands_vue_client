<template>
  <div id="guesses" class="grid10x10" :class="getFreezeCursor">
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
