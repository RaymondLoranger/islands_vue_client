<template>
  <div class="score-box">
    <p>
      <span>
        <span v-html="getScoreTitle('board')"/>
        <img v-if="getScoreImage('board')" :src="getScoreImage('board')">
      </span>
    </p>
    <p>
      <span>
        Hits:&nbsp;{{ getScoreHits('board') }}&nbsp;&nbsp;
        Misses:&nbsp;{{ getScoreMisses('board') }}
      </span>
    </p>
    <p>
      <span>
        <span class="forested">&nbsp;Forested </span>&nbsp;➔
        <span :class="getForested('board', 'atoll')">&nbsp;A </span>
        <span :class="getForested('board', 'dot')">&nbsp;D </span>
        <span :class="getForested('board', 'l_shape')">&nbsp;L </span>
        <span :class="getForested('board', 's_shape')">&nbsp;S </span>
        <span :class="getForested('board', 'square')">&nbsp;Q&nbsp;</span>
      </span>
    </p>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'BoardScore',
  computed: mapGetters([
    'getForested',
    'getScoreHits',
    'getScoreImage',
    'getScoreMisses',
    'getScoreTitle'
  ])
}
</script>

<style scoped>
.score-box {
  display: flex;
  flex-direction: column;
  align-content: center;
  justify-content: center;
  align-items: center;
}
p {
  font-family:'Courier New', Courier, monospace;
  font-size: 1.9vw;
  font-weight: 600;
}
.forested {
  background: ForestGreen;
  color: White;
}
img {
  height: 22px;
  width: 22px;
}
</style>
