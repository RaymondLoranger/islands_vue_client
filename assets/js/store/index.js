import Vuex from 'vuex'
import Vue from 'vue'
import channel from './modules/channel.js'
import gameUrl from './modules/game-url.js'
import guesses from './modules/guesses.js'
import islands from './modules/islands.js'
import messages from './modules/messages.js'
import stats from './modules/stats.js'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    channel,
    gameUrl,
    guesses,
    islands,
    messages,
    stats
  }
})