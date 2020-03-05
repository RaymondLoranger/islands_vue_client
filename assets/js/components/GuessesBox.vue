<template>
  <div class="guesses-box">
    <section class="across">
      <Player/>
    </section>
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
import Corner from '@/components/Corner.vue'
import TagsAcross from '@/components/TagsAcross.vue'
import TagsDown from '@/components/TagsDown.vue'
import Guesses from '@/components/Guesses.vue'
import Player from '@/components/Player.vue'

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
  margin: 0 15px;
}
</style>
