<template>
  <div class="score-box">
    <p>
      <span>
        <span v-html="getScoreTitle('guesses')"/>
        <img v-if="getScoreImage('guesses')" :src="getScoreImage('guesses')">
      </span>
    </p>
    <p>
      <span>
        Hits:&nbsp;{{ getScoreHits('guesses') }}&nbsp;&nbsp;
        Misses:&nbsp;{{ getScoreMisses('guesses') }}
      </span>
    </p>
    <p>
      <span>
        <span class="forested">&nbsp;Forested </span>&nbsp;➔
        <span :class="getForested('guesses', 'atoll')">&nbsp;A </span>
        <span :class="getForested('guesses', 'dot')">&nbsp;D </span>
        <span :class="getForested('guesses', 'l_shape')">&nbsp;L </span>
        <span :class="getForested('guesses', 's_shape')">&nbsp;S </span>
        <span :class="getForested('guesses', 'square')">&nbsp;Q&nbsp;</span>
      </span>
    </p>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GuessesScore',
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
