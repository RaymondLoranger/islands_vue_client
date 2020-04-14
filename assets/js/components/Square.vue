<template>
  <div id="square"
       :draggable="areIslandsDraggable"
       @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('square')" :style="getPosition('square')">
    <div class="a1 square" :class="[getHit('square', 'a1'), getDraggable]"/>
    <div class="b1 square" :class="[getHit('square', 'b1'), getDraggable]"/>
    <div class="a2 square" :class="[getHit('square', 'a2'), getDraggable]"/>
    <div class="b2 square" :class="[getHit('square', 'b2'), getDraggable]"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Square',
  mixins: [listener, islandListener],
  computed: mapGetters([
    'areIslandsDraggable',
    'getDraggable',
    'getHit',
    'getPosition',
    'getVisibility'
  ])
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
.a1.dragging {
  border-left: 1px solid White;
  border-top: 1px solid White;
}
.b1 {
  grid-area: b1;
  position: relative;
  z-index: 1;
}
.b1.dragging {
  border-top: 1px solid White;
  border-right: 1px solid White;
}
.a2 {
  grid-area: a2;
  position: relative;
  z-index: 1;
}
.a2.dragging {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
}
.b2 {
  grid-area: b2;
  position: relative;
  z-index: 1;
}
.b2.dragging {
  border-right: 1px solid White;
  border-bottom: 1px solid White;
}
</style>
