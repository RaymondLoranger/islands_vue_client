const state = {
  directive: ''
}

const getters = {
  getDirective: state => state.directive
}

const actions = {
  setDirective({ commit }, directive) {
    commit('setDirective', directive)
  }
}

const mutations = {
  setDirective(state, directive) {
    state.directive = directive
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}