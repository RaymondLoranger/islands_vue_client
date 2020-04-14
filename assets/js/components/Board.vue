<template>
  <div id="board"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave">
    <div class="square"
         :class="getMiss(square)"
         v-for="square in 100" :key="square" :data-square="square"
         @drop="drop"/>
    <Atoll/>
    <Dot/>
    <L-Shape/>
    <S-Shape/>
    <Square/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import boardListener from '../mixins/boardListener.js'
import Atoll from './Atoll.vue'
import Dot from './Dot.vue'
import L_Shape from './L_Shape.vue'
import S_Shape from './S_Shape.vue'
import Square from './Square.vue'
import { mapGetters } from 'vuex'

export default {
  name: 'Board',
  mixins: [listener, boardListener],
  components: {
    Atoll,
    Dot,
    'L-Shape': L_Shape,
    'S-Shape': S_Shape,
    Square
  },
  computed: mapGetters(['getMiss']),
}
</script>

<style scoped>
#board {
  box-sizing: content-box;
  margin: 0 0;
  position: relative;
  width: calc(3vw * 10 + 9px);
  height: calc(3vw * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid White;
  background: White;
}
.square {
  background: SkyBlue;
}
.miss {
  background: DodgerBlue;
}
</style>
