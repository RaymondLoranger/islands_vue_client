<template>
  <div id="dot"
       draggable="true" @dragstart="dragStart" @dragend="dragEnd"
       @dragenter="dragEnter" @dragover="dragOver" @dragleave="dragLeave"
       class="visible" :style="getPosition('dot')">
    <div class="a1 draggable square"/>
  </div>
</template>

<script>
import listener from '@/mixins/listener.js'
import islandListener from '@/mixins/islandListener.js'
import { mapGetters } from 'vuex'

export default {
  name: 'Dot',
  mixins: [listener, islandListener],
  computed: mapGetters(['getPosition'])
}
</script>

<style scoped>
#dot {
  box-sizing: content-box;
  position: absolute;
  display: grid;
  grid-template-columns: 50px;
  grid-template-rows: 50px;
  grid-template-areas:
    "a1";
  grid-gap: 0px;
}
@media screen and (max-width: 1350px) {
  #dot {
    grid-template-columns: 40px;
    grid-template-rows: 40px;
  }
}
@media screen and (max-width: 1100px) {
  #dot {
    grid-template-columns: 30px;
    grid-template-rows: 30px;
  }
}
@media screen and (max-width: 850px) {
  #dot {
    grid-template-columns: 20px;
    grid-template-rows: 20px;
  }
}

/* Squares
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.a1 {
  grid-area: a1;
  border: 1px solid white;
}
</style>
