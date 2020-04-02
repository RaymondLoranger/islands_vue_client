<template>
  <div class="guesses-box">
    <!-- <section class="across">
      <Player/>
    </section> -->
    <section class="across">
      <Corner/>
      <TagsAcross/>
      <Corner/>
    </section>
    <section class="across">
      <TagsDown/>
      <Guesses/>
      <TagsDown/>
    </section>
    <section class="across">
      <Corner/>
      <TagsAcross/>
      <Corner/>
    </section>
  </div>
</template>

<script>
import Corner from './Corner.vue'
import TagsAcross from './TagsAcross.vue'
import TagsDown from './TagsDown.vue'
import Guesses from './Guesses.vue'
import Player from './Player.vue'

export default {
  name: 'GuessesBox',
  components: {
    Corner,
    TagsAcross,
    TagsDown,
    Guesses,
    Player
  }
}
</script>

<style>
.guesses-box {
  /* margin: 0 15px; */
  margin: 0 0;
}
</style>
