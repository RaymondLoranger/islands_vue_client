const state = {
  messages: [], // [{ sender: 'Adam', gender: 'm', body: 'Howdy!!' }]
  response: {text: ''},
  directive: {text: ''}
}

const getters = {
  getMessages: state => state.messages,
  getResponse: state => state.response.text,
  getDirective: state => state.directive.text
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
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}