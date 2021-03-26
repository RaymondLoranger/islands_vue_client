<template>
  <div id="game-url-group" class="game-url" :class="getGameUrlVisibility">
    <div class="input-group">
      <input id="game-url" ref="gameUrl" class="form-control"
             :value="getGameUrl" :style="gameUrlWidth" readonly>
      <div class="input-group-btn">
        <button id="copy-game-url" class="btn btn-primary" @click="copyGameUrl">
          <i class="fa fa-paste"></i>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GameUrl',
  computed: {
    ...mapGetters(['getGameUrl', 'getGameUrlVisibility']),
    gameUrlWidth() {
      return `width: ${this.getGameUrl.length * 7.9}px`
    }
  },
  methods: {
    fallbackCopyTextToClipboard(text) {
      const textArea = document.createElement('textarea')
      textArea.value = text
      // Avoid scrolling to bottom
      textArea.style.top = '0'
      textArea.style.left = '0'
      textArea.style.position = 'fixed'
      document.body.appendChild(textArea)
      textArea.focus()
      textArea.select()
      try {
        if (document.execCommand('copy')) {
          console.log('Copy to clipboard succeeded')
        } else {
          console.error('Copy to clipboard failed')
        }
      } catch (error) {
        console.error('Copy to clipboard failed:', error)
      }
      document.body.removeChild(textArea)
    },
    copyGameUrl() {
      if (navigator.clipboard) {
        navigator.clipboard.writeText(this.getGameUrl).then(
          _ => console.log('Copy to clipboard succeeded'),
          error => console.error('Copy to clipboard failed:', error)
        )
      } else {
        this.fallbackCopyTextToClipboard(this.getGameUrl)
      }
      this.$refs.gameUrl.focus()
      this.$refs.gameUrl.select()
    }
  },
  updated() {
    if (this.getGameUrlVisibility === 'visible') {
      this.copyGameUrl()
    }
  }
}
</script>

<style scoped>
.game-url {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: calc(25px + 2.5vw);
}
.input-group {
    padding: 15px;
    align-self: center;
    /* min-width: 450px; */
    /* max-width: 500px; */
}
</style>