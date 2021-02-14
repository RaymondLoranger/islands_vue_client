<template>
  <div id="board-score" class="score-box">
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
        <span :class="getForested('board', 'atoll')" title="Atoll">
          &nbsp;A
        </span>
        <span :class="getForested('board', 'dot')" title="Dot">
          &nbsp;D
        </span>
        <span :class="getForested('board', 'l_shape')" title="L-Shape">
          &nbsp;L
        </span>
        <span :class="getForested('board', 's_shape')" title="S-Shape">
          &nbsp;S
        </span>
        <span :class="getForested('board', 'square')" title="Square">
          &nbsp;Q&nbsp;
        </span>
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
