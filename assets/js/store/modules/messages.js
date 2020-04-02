const state = {
  messages: [],
  response: {text: ''},
  directive: {text: ''},
  error: {reason: ''}
}

const getters = {
  getMessages: state => state.messages,
  getResponse: state => state.response.text,
  getDirective: state => state.directive.text,
  getError: state => state.error.reason
}

const actions = {
  pushMessage({ commit }, message) {
    commit('pushMessage', message)
  },
  setResponse({ commit }, response) {
    commit('setResponse', response)
  },
  setDirective({ commit }, directive) {
    commit('setDirective', directive)
  },
  setError({ commit }, error) {
    commit('setError', error)
  }
}

const mutations = {
  pushMessage(state, message) {
    state.messages.push(message)
  },
  setResponse(state, response) {
    state.response = response
  },
  setDirective(state, directive) {
    state.directive = directive
  },
  setError(state, error) {
    state.error = error
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}