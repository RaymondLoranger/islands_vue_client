<template>
  <div id="board-box">
    <section class="across">
      <Corner class="top-left"/>
      <TagsAcross class="top"/>
      <Corner class="top-right"/>
    </section>
    <section class="across">
      <TagsDown class="left"/>
      <Board/>
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
import Board from './Board.vue'

export default {
  name: 'BoardBox',
  components: {
    Corner,
    TagsAcross,
    TagsDown,
    Board
  }
}
</script>
