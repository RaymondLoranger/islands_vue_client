<template>
  <div id="board-control">
    <div v-if="!haveBothPlayersSetIslands" class="control">
      <button @click="randomPositions"
              class="btn btn-primary item center-block"
              :disabled="isGameNew || areIslandsSet">
        Random Positions
      </button>
      <button @click="setIslands"
              class="btn btn-primary item center-block"
              :disabled="isGameNew || areIslandsSet">
        Set Islands
      </button>
    </div>
    <div v-else class="control">
      <label class="radio-inline item" :class="getFreezeCursor">
        <input type="radio" name="mode" id="manual" @change="switchMode"
               value="manual" checked
               :disabled="!areGuessesAllowed || isGameOver">
        <span class="bold">Manual</span>
      </label>
      <label class="radio-inline item" :class="getFreezeCursor">
        <input type="radio" name="mode" id="auto" @change="switchMode"
               value="auto"
               :disabled="!areGuessesAllowed || isGameOver">
        <span class="bold">Auto</span>
      </label>
      <label class="item">
        <input id="pause" type="number" v-model="pause"
               :disabled="!areGuessesAllowed || isGameOver">
        <span class="bold"> ms</span>
      </label>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'BoardControl',
  data() {
    return {
      pause: "0" // no pause...
    }
  },
  computed: mapGetters([
    'areGuessesAllowed',
    'areIslandsSet',
    'getChannel',
    'getFreezeCursor',
    'haveBothPlayersSetIslands',
    'isGameNew',
    'isGameOver'
  ]),
  methods: {
    randomPositions() {
      this.getChannel.push('random_positions', {})
    },
    setIslands() {
      this.getChannel.push('set_islands', {})
    },
    switchMode(e) {
      this.getChannel.push('switch_mode', {
        mode: e.target.value, pause: this.pause
      })
    }
  }
}
</script>

<style scoped>
.control {
  display: flex;
  align-items: center;
  justify-content: space-around;
}
.item {
  margin: 5px 1vw;
}
.bold {
  font-weight: bold;
}
#pause {
  width: 100%;
  min-width: 100px;
  max-width: 100px;
  box-sizing: border-box;
}
</style>
