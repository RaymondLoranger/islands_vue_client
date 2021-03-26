<template>
  <div id="guesses-box">
    <section class="across">
      <Corner class="top-left"/>
      <TagsAcross class="top"/>
      <Corner class="top-right"/>
    </section>
    <section class="across">
      <TagsDown class="left"/>
      <Guesses/>
      <TagsDown class="right"/>
    </section>
    <section class="across">
      <Corner class="bottom-left"/>
      <TagsAcross class="bottom"/>
      <Corner class="bottom-right"/>
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
