<template>
  <div id="square"
       draggable="true" @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('square')" :style="getPosition('square')">
    <div class="a1 draggable square" :class="getHit('square', 'a1')"/>
    <div class="b1 draggable square" :class="getHit('square', 'b1')"/>
    <div class="a2 draggable square" :class="getHit('square', 'a2')"/>
    <div class="b2 draggable square" :class="getHit('square', 'b2')"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Square',
  mixins: [listener, islandListener],
  computed: mapGetters(['getPosition', 'getHit', 'getVisibility'])
}
</script>

<style scoped>
#square {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: 3vw calc(3vw + 1px);
  grid-template-rows: calc(3vw + 1px) 3vw;
  grid-template-areas:
    "a1 b1"
    "a2 b2";
  grid-gap: 0px;
}

/* Squares
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.a1 {
  grid-area: a1;
  position: relative;
  z-index: 1;
}
.a1.dragged {
  border-left: 1px solid White;
  border-top: 1px solid White;
}
.b1 {
  grid-area: b1;
  position: relative;
  z-index: 1;
}
.b1.dragged {
  border-top: 1px solid White;
  border-right: 1px solid White;
}
.a2 {
  grid-area: a2;
  position: relative;
  z-index: 1;
}
.a2.dragged {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
}
.b2 {
  grid-area: b2;
  position: relative;
  z-index: 1;
}
.b2.dragged {
  border-right: 1px solid White;
  border-bottom: 1px solid White;
}
</style>
