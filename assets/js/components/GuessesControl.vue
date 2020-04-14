<template>
  <div id= "guesses-control" class="control">
    <button @click="stopGame"
            class="btn btn-primary item center-block"
            :disabled="!haveBothPlayersSetIslands || !areGuessesAllowed">
      Stop Game
    </button>
    <button @click="randomGuess"
            class="btn btn-primary item center-block"
            :disabled="!haveBothPlayersSetIslands || !areGuessesAllowed">
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
    'haveBothPlayersSetIslands'
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

<style scoped>
.control {
  display: flex;
  justify-content: space-evenly;
}
.item {
  margin: 5px 1vw;
}
</style>
