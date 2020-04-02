import Vuex from 'vuex'
import Vue from 'vue'
import channel from './modules/channel.js'
// import gameState from './modules/game-state.js'
import gameUrl from './modules/game-url.js'
import guesses from './modules/guesses.js'
import islands from './modules/islands.js'
import messages from './modules/messages.js'
import players from './modules/players.js'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    channel,
    // gameState,
    gameUrl,
    guesses,
    islands,
    messages,
    players
  }
})