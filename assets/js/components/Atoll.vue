<template>
  <div id="atoll" title="Atoll"
       :draggable="areIslandsDraggable"
       @dragstart="dragStart" @dragend="dragEnd" @drop="drop"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('atoll')" :style="getPosition('atoll')">
    <div class="a1 square" :class="[getHit('atoll', 'a1'), getDraggable]"/>
    <div class="a2" draggable="true" @dragstart="dragHalt"/>
    <div class="b1 square" :class="[getHit('atoll', 'b1'), getDraggable]"/>
    <div class="b2 square" :class="[getHit('atoll', 'b2'), getDraggable]"/>
    <div class="a3 square" :class="[getHit('atoll', 'a3'), getDraggable]"/>
    <div class="b3 square" :class="[getHit('atoll', 'b3'), getDraggable]"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Atoll',
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
#atoll {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: calc(var(--ss) + 1px) var(--ss);
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
  border-bottom: 1px solid White;
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
  z-index: 0;
}
.b2 {
  grid-area: b2;
  position: relative;
  z-index: 1;
}
.b2.dragging {
  border-right: 1px solid White;
  border-left: 1px solid White;
}
.a3 {
  grid-area: a3;
  position: relative;
  z-index: 1;
}
.a3.dragging {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
  border-top: 1px solid White;
}
.b3 {
  grid-area: b3;
  position: relative;
  z-index: 1;
}
.b3.dragging {
  border-right: 1px solid White;
  border-bottom: 1px solid White;
}
</style>
