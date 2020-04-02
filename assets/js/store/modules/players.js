import { Presence } from "phoenix"

const state = {  // 'initialized', 'players_set',
  gameState: '', // 'player1_turn', 'player2_turn' or 'game_over'
  player_id: '', // 'player1' or 'player2'
  scores: {
    board: { name: '', gender: '', hits: 0, misses: 0, forested_types: [] },
    guesses: { name: '', gender: '', hits: 0, misses: 0, forested_types: [] }
  },          // [{ player_id: 'player1', player_name: 'Ray', gender: 'm',
  players: [] //    online_at: '2020-03-26 19:06:02.960000Z',
}             //    hits: 4, misses: 7, forested_types: ['atoll, 'dot'] }]

const getters = {
  getFreeze: state => state.player_id + '_turn' !== state.gameState,
  getGameState: state => state.gameState,
  getBoardScore: state => state.scores.board,
  getGuessesScore: state => state.scores.guesses,
  getPlayers: state => state.players
}

const actions = {
  setGameState({ commit }, payload) {
    commit('setGameState', payload)
  },
  setPlayerId({ commit }, player_id) {
    commit('setPlayerId', player_id)
  },
  setBoardScore({ commit }, boardScore) {
    commit('setBoardScore', boardScore)
  },
  setGuessesScore({ commit }, guessesScore) {
    commit('setGuessesScore', guessesScore)
  },
  setPlayers({ commit }, presences) { // Assumes scores is up-to-date.
    const listBy = (player_id, { metas: [first, ..._rest] }) => {
      const { online_at, player_name, gender } = first
      const player = { player_id, player_name, gender, online_at }
      const key = player_id === state.player_id ? 'guesses' : 'board'
      player.hits = state.scores[key].hits
      player.misses = state.scores[key].misses
      player.forested_types = state.scores[key].forested_types
      return player
    }
    commit('setPlayers', Presence.list(presences, listBy))
  }
}

const mutations = {
  setGameState(state, { game_state }) {
    state.gameState = game_state
  },
  setPlayerId(state, player_id) {
    state.player_id = player_id
  },
  setBoardScore(state, boardScore) {
    state.scores.board = boardScore
  },
  setGuessesScore(state, guessesScore) {
    state.scores.guesses = guessesScore
  },
  setPlayers(state, players) {
    state.players = players
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}