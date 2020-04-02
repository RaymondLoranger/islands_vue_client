const state = {
  channel: {}
}

const getters = {
  getChannel: state => state.channel
}

const actions = {
  setChannel({ commit }, channel) {
    commit('setChannel', channel)
  }
}

const mutations = {
  setChannel(state, channel) {
    state.channel = channel
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}