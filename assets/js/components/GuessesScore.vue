<template>
  <div id="guesses-score" class="score-box">
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
        <span :class="getForested('guesses', 'atoll')" title="Atoll">
          &nbsp;A
        </span>
        <span :class="getForested('guesses', 'dot')" title="Dot">
          &nbsp;D
        </span>
        <span :class="getForested('guesses', 'l_shape')" title="L-Shape">
          &nbsp;L
        </span>
        <span :class="getForested('guesses', 's_shape')" title="S-Shape">
          &nbsp;S
        </span>
        <span :class="getForested('guesses', 'square')" title="Square">
          &nbsp;Q&nbsp;
        </span>
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
