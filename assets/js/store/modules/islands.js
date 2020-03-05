const state = {
  positions: {
    atoll: { gridColumnStart: 1, gridRowStart: 1 },
    dot: { gridColumnStart: 9, gridRowStart: 9 },
    l_shape: { gridColumnStart: 7, gridRowStart: 3 },
    s_shape: { gridColumnStart: 2, gridRowStart: 6 },
    square: { gridColumnStart: 5, gridRowStart: 9 }
  },
  dimensions: {
    atoll: { squaresAcross: 2, squaresDown: 3 },
    dot: { squaresAcross: 1, squaresDown: 1 },
    l_shape: { squaresAcross: 2, squaresDown: 3 },
    s_shape: { squaresAcross: 3, squaresDown: 2 },
    square: { squaresAcross: 2, squaresDown: 2 }
  }
}

const getters = {
  getPosition: state => islandId => state.positions[islandId],
  getDimension: state => islandId => state.dimensions[islandId]
}

const actions = {
  position({ commit }, payload) {
    commit('setPosition', payload)
  }
}

const mutations = {
  setPosition(state, { islandId, position }) {
    state.positions[islandId] = position
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}