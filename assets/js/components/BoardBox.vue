<template>
  <div class="board-box">
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
      <Board/>
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
import Board from './Board.vue'
import Player from './Player.vue'

export default {
  name: 'BoardBox',
  components: {
    Corner,
    TagsAcross,
    TagsDown,
    Board,
    Player
  }
}
</script>

<style scoped>
.board-box {
  /* margin: 0 15px; */
  margin: 0 0;
}
</style>
