<template>
  <div id= "guesses-control" class="control">
    <button class="btn btn-primary item center-block">Stop Game</button>
    <button @click="randomGuess"
            class="btn btn-primary item center-block">
      Random Guess
    </button>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GuessesControl',
  computed: mapGetters(['getChannel']),
  methods: {
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
  /* flex: 1 1 0px; */
  margin: 5px 1vw;
  /* font-size: 2vw; */
}
</style>
