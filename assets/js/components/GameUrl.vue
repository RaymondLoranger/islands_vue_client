<template>
  <div class="game-url" :class="getGameUrlVisibility">
    <div class="input-group">
      <input id="game-url" class="form-control"
              :value="getGameUrl" readonly>
      <div class="input-group-btn">
        <button id="copy-game-url" class="btn btn-primary"
                data-clipboard-target="#game-url">
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
    ...mapGetters(['getGameState', 'getGameUrl']),
    getGameUrlVisibility() {
      return this.getGameState === 'initialized' ? 'visible' : 'hidden'
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