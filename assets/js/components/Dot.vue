<template>
  <div id="dot"
       :draggable="areIslandsDraggable"
       @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('dot')" :style="getPosition('dot')">
    <div class="a1 square" :class="[getHit('dot', 'a1'), getDraggable]"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Dot',
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
#dot {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: 3vw;
  grid-template-rows: 3vw;
  grid-template-areas:
    "a1";
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
  border: 1px solid White;
}
</style>
