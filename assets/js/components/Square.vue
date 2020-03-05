<template>
  <div id="square"
       draggable="true" @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       class="visible" :style="getPosition('square')">
    <div class="a1 draggable square"/>
    <div class="b1 draggable square"/>
    <div class="a2 draggable square"/>
    <div class="b2 draggable square"/>
  </div>
</template>

<script>
import listener from '@/mixins/listener.js'
import islandListener from '@/mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Square',
  mixins: [listener, islandListener],
  computed: mapGetters(['getPosition'])
}
</script>

<style scoped>
#square {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: 50px calc(50px + 1px);
  grid-template-rows: calc(50px + 1px) 50px;
  grid-template-areas:
    "a1 b1"
    "a2 b2";
  grid-gap: 0px;
}
@media screen and (max-width: 1350px) {
  #square {
    grid-template-columns: 40px calc(40px + 1px);
    grid-template-rows: calc(40px + 1px) 40px;
  }
}
@media screen and (max-width: 1100px) {
  #square {
    grid-template-columns: 30px calc(30px + 1px);
    grid-template-rows: calc(30px + 1px) 30px;
  }
}
@media screen and (max-width: 850px) {
  #square {
    grid-template-columns: 20px calc(20px + 1px);
    grid-template-rows: calc(20px + 1px) 20px;
  }
}

/* Squares
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.a1 {
  grid-area: a1;
  border-left: 1px solid white;
  border-top: 1px solid white;
}
.b1 {
  grid-area: b1;
  border-top: 1px solid white;
  border-right: 1px solid white;
}
.a2 {
  grid-area: a2;
  border-bottom: 1px solid white;
  border-left: 1px solid white;
}
.b2 {
  grid-area: b2;
  border-right: 1px solid white;
  border-bottom: 1px solid white;
}
</style>
