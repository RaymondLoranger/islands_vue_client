<template>
  <div id="board-control">
    <div v-if="settingIslands" class="control">
      <button @click="randomPositions"
              class="btn btn-primary item center-block">
        Random Positions
      </button>
      <button @click="setIslands"
              class="btn btn-primary item center-block">
        Set Islands
      </button>
    </div>
    <div v-else>
      <label class="radio-inline">
        <input type="radio" name="mode" id="manual" @change="switchMode"
               value="manual" :disabled="gameOver" checked>
        <span class="bold">Manual</span>
      </label>
      <label class="radio-inline">
        <input type="radio" name="mode" id="auto" @change="switchMode"
               value="auto" :disabled="gameOver">
        <span class="bold">Auto</span>
      </label>
      <input id="pause" type="number" v-model="pause" :disabled="gameOver"
             >
      <span class="bold"> ms</span>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'BoardControl',
  data() {
    return {
      pause: "2000"
    }
  },
  computed: {
    ...mapGetters(['getChannel', 'getGameState']),
    settingIslands() {
      return ['initialized', 'players_set'].includes(this.getGameState)
    },
    gameOver() {
      return this.getGameState === 'game_over'
    }
  },
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
  justify-content: space-evenly;
}
.item {
  /* flex: 1 1 0px; */
  margin: 5px 1vw;
  /* font-size: 2vw; */
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
