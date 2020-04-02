const state = {
  positions: {
    atoll: null,   // atoll: { gridColumnStart: 2, gridRowStart: 2 }
    dot: null,     // dot: { gridColumnStart: 9, gridRowStart: 9 }
    l_shape: null, // l_shape: { gridColumnStart: 7, gridRowStart: 3 }
    s_shape: null, // s_shape: { gridColumnStart: 2, gridRowStart: 6 }
    square: null   // square: { gridColumnStart: 5, gridRowStart: 9 }
  },
  dimensions: {
    atoll: { squaresAcross: 2, squaresDown: 3 },
    dot: { squaresAcross: 1, squaresDown: 1 },
    l_shape: { squaresAcross: 2, squaresDown: 3 },
    s_shape: { squaresAcross: 3, squaresDown: 2 },
    square: { squaresAcross: 2, squaresDown: 2 }
  },
  hits: {
    atoll: [],   // atoll: ['b1', 'b2', 'b3']
    dot: [],     // dot: ['a1']
    l_shape: [], // l_shape: ['a3']
    s_shape: [], // s_shape: ['b1']
    square: []   // square: ['a1']
  },
  misses: {squares: []} // misses: {squares: [2, 43, 84]}
}

const getters = {
  getPosition: state => islandId => state.positions[islandId],
  getDimension: state => islandId => state.dimensions[islandId],
  getHit: state => (islandId, square) =>
    state.hits[islandId].includes(square) ? 'hit' : '',
  getMiss: state => square =>
    state.misses.squares.includes(square) ? 'miss' : '',
  getVisibility: state => islandId =>
    state.positions[islandId] ? 'visible' : 'hidden'
}

const actions = {
  setPosition({ commit }, payload) {
    commit('setPosition', payload)
  },
  setPositions({ commit }, positions) {
    commit('setPositions', positions)
  },
  setHits({ commit }, hits) {
    commit('setHits', hits)
  },
  setMisses({ commit }, misses) {
    commit('setMisses', misses)
  }
}

const mutations = {
  setPosition(state, { islandId, position }) {
    state.positions[islandId] = position
  },
  setPositions(state, positions) {
    state.positions = positions
  },
  setHits(state, hits) {
    state.hits = hits
  },
  setMisses(state, misses) {
    state.misses = misses
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}