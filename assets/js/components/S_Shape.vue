<template>
  <div id="s_shape"
       draggable="true" @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       class="visible" :style="getPosition('s_shape')">
    <div class="a1" draggable="true" @dragstart="dragHalt" @drop="drop"/>
    <div class="b1 draggable square"/>
    <div class="c1 draggable square"/>
    <div class="a2 draggable square"/>
    <div class="b2 draggable square"/>
    <div class="c2" draggable="true" @dragstart="dragHalt" @drop="drop"/>
  </div>
</template>

<script>
import listener from '@/mixins/listener.js'
import islandListener from '@/mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'S_Shape',
  mixins: [listener, islandListener],
  computed: mapGetters(['getPosition'])
}
</script>

<style scoped>
#s_shape {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: calc(50px + 1px) 50px calc(50px + 1px);
  grid-template-rows: 50px calc(50px + 1px);
  grid-template-areas:
    "a1 b1 c1"
    "a2 b2 c2";
  grid-gap: 0px;
}
@media screen and (max-width: 1350px) {
  #s_shape {
    grid-template-columns: calc(40px + 1px) 40px calc(40px + 1px);
    grid-template-rows: 40px calc(40px + 1px);
  }
}
@media screen and (max-width: 1100px) {
  #s_shape {
    grid-template-columns: calc(30px + 1px) 30px calc(30px + 1px);
    grid-template-rows: 30px calc(30px + 1px);
  }
}
@media screen and (max-width: 850px) {
  #s_shape {
    grid-template-columns: calc(20px + 1px) 20px calc(20px + 1px);
    grid-template-rows: 20px calc(20px + 1px);
  }
}

/* Squares
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.a1 {
  grid-area: a1;
  visibility: visible;
}
.b1 {
  grid-area: b1;
  border-left: 1px solid white;
  border-top: 1px solid white;
}
.c1 {
  grid-area: c1;
  border-top: 1px solid white;
  border-right: 1px solid white;
  border-bottom: 1px solid white;
}
.a2 {
  grid-area: a2;
  border-bottom: 1px solid white;
  border-left: 1px solid white;
  border-top: 1px solid white;
}
.b2 {
  grid-area: b2;
  border-right: 1px solid white;
  border-bottom: 1px solid white;
}
.c2 {
  grid-area: c2;
  visibility: visible;
}
</style>
