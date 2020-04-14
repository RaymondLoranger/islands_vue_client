<template>
  <div class="game-url" :class="getGameUrlVisibility">
    <div class="input-group">
      <input id="game-url" ref="gameUrl" class="form-control"
             :value="getGameUrl" readonly>
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
  computed: mapGetters(['getGameUrl', 'getGameUrlVisibility']),
  methods: {
    copyGameUrl() {
      navigator.clipboard.writeText(this.getGameUrl).then(
        _ => console.log('Copy to clipboard succeeded'),
        error => console.error('Copy to clipboard failed:', error)
      )
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
    width: 100vw;
    height: 7vw;
}
.input-group {
    padding: 15px;
    align-self: center;
    min-width: 400px;
    max-width: 450px;
}
</style>