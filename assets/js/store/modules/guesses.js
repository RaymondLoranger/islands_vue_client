const state = {
  hits: { squares: [] },  // hits: [24, 25, 37, 48, 83]
  misses: { squares: [] } // misses: [2, 43, 70, 74, 84]
}

const getters = {
  getGuess: state => square =>
    state.hits.squares.includes(square) ? 'hit' :
    state.misses.squares.includes(square) ? 'miss' : ''
}

const actions = {
  setGuessesHits({ commit }, hits) {
    commit('setGuessesHits', hits)
  },
  setGuessesMisses({ commit }, misses) {
    commit('setGuessesMisses', misses)
  }
}

const mutations = {
  setGuessesHits(state, hits) {
    state.hits = hits
  },
  setGuessesMisses(state, misses) {
    state.misses = misses
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}