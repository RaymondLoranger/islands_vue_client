<template>
  <div id="board-control">
    <div v-if="!haveBothPlayersSetIslands" class="control">
      <button @click="randomPositions"
              class="btn btn-primary game-btn control-item center-block"
              :disabled="isGameNew || areIslandsSet || isGameOver">
        Random Positions
      </button>
      <button @click="setIslands"
              class="btn btn-primary game-btn control-item center-block"
              :disabled="isGameNew || areIslandsSet || isGameOver">
        Set Islands
      </button>
    </div>
    <div v-else class="control">
      <form id="mode-and-pause-form">
        <label class="radio-inline control-item" :class="getFreezeCursor">
          <input type="radio" name="mode" id="manual" @change="switchMode"
                 value="manual" checked
                 :disabled="!areGuessesAllowed || isGameOver">
          <span class="radio-label">Manual</span>
        </label>
        <label class="radio-inline control-item" :class="getFreezeCursor">
          <input type="radio" name="mode" id="auto" @change="switchMode"
                 value="auto"
                 :disabled="!areGuessesAllowed || isGameOver || isModeAuto">
          <span class="radio-label">Auto</span>
        </label>
        <label class="control-item">
          <input id="pause" type="number" v-model="pause" min="0" max="10000"
                 ref="pause"
                 :disabled="!areGuessesAllowed || isGameOver || isModeAuto">
          <span class="radio-label"> ms</span>
        </label>
        <button ref="showInvalid" class="hidden"/>
      </form>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'BoardControl',
  data() {
    return {
      pause: '0' // no pause initially...
    }
  },
  computed: mapGetters([
    'areGuessesAllowed',
    'areIslandsSet',
    'getChannel',
    'getFreezeCursor',
    'haveBothPlayersSetIslands',
    'isGameNew',
    'isGameOver',
    'isModeAuto'
  ]),
  methods: {
    randomPositions() {
      this.getChannel.push('random_positions', {})
    },
    setIslands() {
      this.getChannel.push('set_islands', {})
    },
    switchMode(e) {
      if (this.$refs.pause.checkValidity()) {
        this.getChannel.push('switch_mode', {
          mode: e.target.value, pause: this.pause
        })
      } else {
        this.$refs.showInvalid.click()
      }
    }
  }
}
</script>

<style scoped>
input[type=radio] {
  position: static;
  margin: 0;
}
.radio-label {
  font-size: calc(8px + 0.6vw);
  font-weight: bold;
}
#pause {
  font-size: calc(6px + 0.6vw);
  max-width: 75px;
}
</style>
