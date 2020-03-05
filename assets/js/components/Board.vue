<template>
  <div id="board"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave">
    <div class="square"
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
import listener from '@/mixins/listener.js'
import boardListener from '@/mixins/boardListener.js'
import Atoll from '@/components/Atoll.vue'
import Dot from '@/components/Dot.vue'
import L_Shape from '@/components/L_Shape.vue'
import S_Shape from '@/components/S_Shape.vue'
import Square from '@/components/Square.vue'

export default {
  name: 'Board',
  mixins: [listener, boardListener],
  components: {
    Atoll,
    Dot,
    'L-Shape': L_Shape,
    'S-Shape': S_Shape,
    Square
  }
}
</script>

<style scoped>
#board {
  box-sizing: content-box;
  margin: 0 0;
  position: relative;
  width: calc(50px * 10 + 9px);
  height: calc(50px * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid white;
  background: white;
}
.square {
  background: SkyBlue;
}
@media screen and (max-width: 1350px) {
  #board {
    width: calc(40px * 10 + 9px);
    height: calc(40px * 10 + 9px);
  }
}
@media screen and (max-width: 1100px) {
  #board {
    width: calc(30px * 10 + 9px);
    height: calc(30px * 10 + 9px);
  }
}
@media screen and (max-width: 850px) {
  #board {
    width: calc(20px * 10 + 9px);
    height: calc(20px * 10 + 9px);
  }
}
</style>
