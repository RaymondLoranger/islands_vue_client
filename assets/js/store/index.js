import Vuex from 'vuex'
import Vue from 'vue'
import islands from '@/store/modules/islands.js'
import players from '@/store/modules/players.js'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    islands,
    players
  }
})