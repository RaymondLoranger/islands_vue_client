const state = {
  gameState: '' // 'initialized', 'players_set',
}               // 'player1_turn', 'player2_turn' or 'game_over'

const getters = {
  getGameState: state => state.gameState
}

const actions = {
  setGameState({ commit }, payload) {
    commit('setGameState', payload)
  }
}

const mutations = {
  setGameState(state, { game_state }) {
    state.gameState = game_state
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}