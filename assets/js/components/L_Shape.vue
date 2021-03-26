<template>
  <div id="l_shape" title="L-Shape"
       :draggable="areIslandsDraggable"
       @dragstart="dragStart" @dragend="dragEnd" @drop="drop"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('l_shape')" :style="getPosition('l_shape')">
    <div class="a1 square" :class="[getHit('l_shape', 'a1'), getDraggable]"/>
    <div class="a2 square" :class="[getHit('l_shape', 'a2'), getDraggable]"/>
    <div class="b1" draggable="true" @dragstart="dragHalt"/>
    <div class="b2" draggable="true" @dragstart="dragHalt"/>
    <div class="a3 square" :class="[getHit('l_shape', 'a3'), getDraggable]"/>
    <div class="b3 square" :class="[getHit('l_shape', 'b3'), getDraggable]"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'L_Shape',
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
#l_shape {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: var(--ss) calc(var(--ss) + 1px);
  grid-template-rows: var(--ss) calc(var(--ss) + 2px) var(--ss);
  grid-template-areas:
    "a1 b1"
    "a2 b2"
    "a3 b3";
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
  border-right: 1px solid White;
}
.b1 {
  grid-area: b1;
  position: relative;
  z-index: 0;
}
.a2 {
  grid-area: a2;
  position: relative;
  z-index: 1;
}
.a2.dragging {
  border-right: 1px solid White;
  border-left: 1px solid White;
}
.b2 {
  grid-area: b2;
  position: relative;
  z-index: 0;
}
.a3 {
  grid-area: a3;
  position: relative;
  z-index: 1;
}
.a3.dragging {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
}
.b3 {
  grid-area: b3;
  position: relative;
  z-index: 1;
}
.b3.dragging {
  border-top: 1px solid White;
  border-right: 1px solid White;
  border-bottom: 1px solid White;
}
</style>
