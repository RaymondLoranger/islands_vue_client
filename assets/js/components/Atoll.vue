<template>
  <div id="atoll"
       draggable="true" @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       :class="getVisibility('atoll')" :style="getPosition('atoll')">
    <div class="a1 draggable square" :class="getHit('atoll', 'a1')"/>
    <div class="a2" draggable="true" @dragstart="dragHalt" @drop="drop"/>
    <div class="b1 draggable square" :class="getHit('atoll', 'b1')"/>
    <div class="b2 draggable square" :class="getHit('atoll', 'b2')"/>
    <div class="a3 draggable square" :class="getHit('atoll', 'a3')"/>
    <div class="b3 draggable square" :class="getHit('atoll', 'b3')"/>
  </div>
</template>

<script>
import listener from '../mixins/listener.js'
import islandListener from '../mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Atoll',
  mixins: [listener, islandListener],
  computed: mapGetters(['getPosition', 'getHit', 'getVisibility'])
}
</script>

<style scoped>
#atoll {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: calc(3vw + 1px) 3vw;
  grid-template-rows: 3vw calc(3vw + 2px) 3vw;
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
  /* border-bottom: 1px Chocolate;
  border-left: 1px Chocolate;
  border-top: 1px Chocolate; */
  position: relative;
  z-index: 1;
}
.a2 {
  grid-area: a2;
  visibility: visible;
  position: relative;
  z-index: 0;
}
.b1 {
  grid-area: b1;
  /* border-top: 1px Chocolate;
  border-right: 1px Chocolate; */
  position: relative;
  z-index: 1;
}
.b2 {
  grid-area: b2;
  /* border-right: 1px Chocolate;
  border-left: 1px Chocolate; */
  position: relative;
  z-index: 1;
}
.a3 {
  grid-area: a3;
  /* border-bottom: 1px Chocolate;
  border-left: 1px Chocolate;
  border-top: 1px Chocolate; */
  position: relative;
  z-index: 1;
}
.b3 {
  grid-area: b3;
  /* border-right: 1px Chocolate;
  border-bottom: 1px Chocolate; */
  position: relative;
  z-index: 1;
}
</style>
