<template>
  <div class="score-box">
    <p><span>{{ name }} <img :src="img_src" height="22" width="22"></span></p>
    <p><span>Hits:&nbsp;{{ hits }}&nbsp;&nbsp;
             Misses:&nbsp;{{ misses }}</span></p>
    <p>
      <span>
        <span class="forested">&nbsp;Forested </span>&nbsp;=>
        <span :class="atoll">&nbsp;A </span>
        <span :class="dot">&nbsp;D </span>
        <span :class="l_shape">&nbsp;L </span>
        <span :class="s_shape">&nbsp;S </span>
        <span :class="square">&nbsp;Q&nbsp;</span>
      </span>
    </p>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GuessesScore',
  computed: {
    ...mapGetters(['getGuessesScore']),
    name() {
      const name = this.getGuessesScore.name
      return name === '?' ? '' : `${name}'s Board`
    },
    hits() {
      return this.getGuessesScore.hits
    },
    misses() {
      return this.getGuessesScore.misses
    },
    img_src() {
      if (this.getGuessesScore.name === '?') {
        return '/images/question-mark.png'
      } else if (this.getGuessesScore.gender === 'm') {
        return '/images/male.png'
      } else {
        return '/images/female.png'
      }
    },
    forested_types() {
      return this.getGuessesScore.forested_types
    },
    atoll() {
      return { forested: this.forested_types.includes('atoll') }
    },
    dot() {
      return { forested: this.forested_types.includes('dot') }
    },
    l_shape() {
      return { forested: this.forested_types.includes('l_shape') }
    },
    s_shape() {
      return { forested: this.forested_types.includes('s_shape') }
    },
    square() {
      return { forested: this.forested_types.includes('square') }
    }
  }
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
</style>
