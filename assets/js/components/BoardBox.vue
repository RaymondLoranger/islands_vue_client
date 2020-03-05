<template>
  <div class="board-box">
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
import Corner from '@/components/Corner.vue'
import TagsAcross from '@/components/TagsAcross.vue'
import TagsDown from '@/components/TagsDown.vue'
import Board from '@/components/Board.vue'
import Player from '@/components/Player.vue'

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
  margin: 0 15px;
}
</style>
