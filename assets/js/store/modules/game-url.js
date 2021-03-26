const state = {
  gameUrl: ''
}

const getters = {
  getGameUrl: state => state.gameUrl
}

const actions = {
  setGameUrl({ commit }, gameUrl) {
    commit('setGameUrl', gameUrl)
  }
}

const mutations = {
  setGameUrl(state, gameUrl) {
    state.gameUrl = gameUrl
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}