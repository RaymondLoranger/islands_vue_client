<template>
  <div id="guesses-control" class="control">
    <button @click="stopGame"
            class="btn btn-primary game-btn control-item center-block"
            :disabled="!haveBothPlayersSetIslands || !areGuessesAllowed ||
                       isModeAuto">
      Stop Game
    </button>
    <button @click="randomGuess"
            class="btn btn-primary game-btn control-item center-block"
            :disabled="!haveBothPlayersSetIslands || !areGuessesAllowed ||
                       isModeAuto">
      Random Guess
    </button>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GuessesControl',
  computed: mapGetters([
    'areGuessesAllowed',
    'getChannel',
    'haveBothPlayersSetIslands',
    'isModeAuto'
  ]),
  methods: {
    stopGame() {
      this.getChannel.push('stop_game', {})
    },
    randomGuess() {
      this.getChannel.push('random_guess', {})
    }
  }
}
</script>
