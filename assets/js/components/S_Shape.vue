<template>
  <div id="s_shape"
       :draggable="areIslandsDraggable"
       @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('s_shape')" :style="getPosition('s_shape')">
    <div class="a1" draggable="true" @dragstart="dragHalt" @drop="drop"/>
    <div class="b1 square" :class="[getHit('s_shape', 'b1'), getDraggable]"/>
    <div class="c1 square" :class="[getHit('s_shape', 'c1'), getDraggable]"/>
    <div class="a2 square" :class="[getHit('s_shape', 'a2'), getDraggable]"/>
    <div class="b2 square" :class="[getHit('s_shape', 'b2'), getDraggable]"/>
    <div class="c2" draggable="true" @dragstart="dragHalt" @drop="drop"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'S_Shape',
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
#s_shape {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: calc(3vw + 1px) 3vw calc(3vw + 1px);
  grid-template-rows: 3vw calc(3vw + 1px);
  grid-template-areas:
    "a1 b1 c1"
    "a2 b2 c2";
  grid-gap: 0px;
}

/* Squares
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.a1 {
  grid-area: a1;
  position: relative;
  z-index: 0;
}
.b1 {
  grid-area: b1;
  position: relative;
  z-index: 1;
}
.b1.dragging {
  border-left: 1px solid White;
  border-top: 1px solid White;
}
.c1 {
  grid-area: c1;
  position: relative;
  z-index: 1;
}
.c1.dragging {
  border-top: 1px solid White;
  border-right: 1px solid White;
  border-bottom: 1px solid White;
}
.a2 {
  grid-area: a2;
  position: relative;
  z-index: 1;
  border-top: 1px solid White; /* Simulate grid gap. */
}
.a2.dragging {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
  border-top: 1px solid White;
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
.c2 {
  grid-area: c2;
  position: relative;
  z-index: 0;
}
</style>
