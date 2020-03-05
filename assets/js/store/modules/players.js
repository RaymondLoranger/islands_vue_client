const state = {
  players: {
    player: {
      name: 'Adam', gender: 'M',
      hits: 4, misses: 7, forested: ['a', 'l', 'd']
    },
    opponent: {
      name: 'Eve', gender: 'F',
      hits: 6, misses: 11, forested: ['s', 'q']
    }
  }
}

const getters = {
  getPlayer: state => state.players.player,
  getOpponent: state => state.players.opponent
}

const actions = {
  updatePlayer({ commit }, player) {
    commit('updatePlayer', player)
  },
  updateOpponent({ commit }, opponent) {
    commit('updateOpponent', opponent)
  }
}

const mutations = {
  updatePlayer(state, player) {
    state.players.player = player
  },
  updateOpponent(state, opponent) {
    state.players.opponent = opponent
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}