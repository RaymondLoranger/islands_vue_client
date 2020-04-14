<template>
  <div class="guesses-box">
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

export default {
  name: 'GuessesBox',
  components: {
    Corner,
    TagsAcross,
    TagsDown,
    Guesses
  }
}
</script>

<style>
.guesses-box {
  margin: 0 0;
}
</style>
