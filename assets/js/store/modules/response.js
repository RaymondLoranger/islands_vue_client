const state = {
  response: ''
}

const getters = {
  getResponse: state => state.response
}

const actions = {
  setResponse({ commit }, response) {
    commit('setResponse', response)
  }
}

const mutations = {
  setResponse(state, response) {
    state.response = response
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}