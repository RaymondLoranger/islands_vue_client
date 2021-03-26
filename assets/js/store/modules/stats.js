import { Presence } from 'phoenix'

const hasGameFailed = state => state.error.reason && !state.gameState
const isNameUnknown = (state, scoreId) =>
  ['', '?'].includes(state.scores[scoreId].name)
const title = (state, scoreId) =>
  state.scores[scoreId].gender === 'f' ?
  `<span class="female">${state.scores[scoreId].name}</span>'s Board` :
  `<span class="male">${state.scores[scoreId].name}</span>'s Board`
const areIslandsDraggable = state =>
  state.gameState === 'players_set' && state.playerState === 'islands_not_set'
const areGuessesAllowed = state => state.playerId + '_turn' === state.gameState

const state = {        // 'initialized', 'players_set',
  gameState: '',       // 'player1_turn', 'player2_turn' or 'game_over'
  error: {reason: ''}, // e.g. Cannot join game 'blue-moon-1234'.
  playerState: '',     // 'islands_not_set' or 'islands_set'
  playerId: '',        // 'player1' or 'player2'
  haveBothPlayersSetIslands: false,
  mode: 'manual',
  scores: {
    board: { name: '', gender: '', hits: 0, misses: 0, forested_types: [] },
    guesses: { name: '', gender: '', hits: 0, misses: 0, forested_types: [] }
  },          // [{ player_id: 'player1', player_name: 'Ray', gender: 'm',
  players: [] //    online_at: '2020-03-26 19:06:02.960000Z',
}             //    hits: 4, misses: 7, forested_types: ['atoll, 'dot'] }]

const getters = {
  getGameUrlVisibility: state =>
    state.gameState === 'initialized' ? 'visible' : 'hidden',
  getScoreTitle: state => scoreId =>
    isNameUnknown(state, scoreId) ? '' : title(state, scoreId),
  getScoreImage: state => scoreId =>
    hasGameFailed(state) ? '/images/no-entry-sign.png' :
    state.scores[scoreId].name === '?' ? '/images/question-mark.png' :
    state.scores[scoreId].gender === 'm' ? '/images/male-sign.png' :
    state.scores[scoreId].gender === 'f' ? '/images/female-sign.png' : '',
  getScoreHits: state => scoreId => state.scores[scoreId].hits,
  getScoreMisses: state => scoreId => state.scores[scoreId].misses,
  getForested: state => (scoreId, islandId) =>
    state.scores[scoreId].forested_types.includes(islandId) ? 'forested' : '',
  areIslandsDraggable: state => areIslandsDraggable(state),
  getDraggable: state =>
    areIslandsDraggable(state) ? 'draggable' : 'freeze-cursor',
  areGuessesAllowed: state => areGuessesAllowed(state),
  getFreezeCursor: state => areGuessesAllowed(state) ? '' : 'freeze-cursor',
  getFreezeEvents: state => areGuessesAllowed(state) ? '' : 'freeze-events',
  haveBothPlayersSetIslands: state => state.haveBothPlayersSetIslands,
  isGameOver: state => state.gameState === 'game_over',
  isGameNew: state => ['', 'initialized'].includes(state.gameState),
  areIslandsSet: state => state.playerState === 'islands_set',
  isModeAuto: state => state.mode === 'auto',
  getPlayers: state => state.players,
  getError: state => state.error.reason
}

const actions = {
  setGameState({ commit }, { gameState }) {
    if (state.gameState === 'players_set' && gameState === 'player1_turn') {
      commit('haveBothPlayersSetIslands', true)
    }
    commit('setGameState', { gameState })
  },
  setPlayerState({ commit }, payload) {
    commit('setPlayerState', payload)
  },
  setPlayerId({ commit }, playerId) {
    commit('setPlayerId', playerId)
  },
  setScore({ commit }, payload) {
    commit('setScore', payload)
  },
  setPlayers({ commit }, presences) { // assumes state.scores is up-to-date
    const listBy = (player_id, { metas: [first, ..._rest] }) => {
      const { online_at, player_name, gender } = first
      const player = { player_id, player_name, gender, online_at }
      const scoreId = player_id === state.playerId ? 'guesses' : 'board'
      player.hits = state.scores[scoreId].hits
      player.misses = state.scores[scoreId].misses
      player.forested_types = state.scores[scoreId].forested_types
      return player
    }
    commit('setPlayers', presences.list(listBy))
  },
  setError({ commit }, error) {
    commit('setError', error)
  },
  setMode({ commit }, payload) {
    commit('setMode', payload)
  }
}

const mutations = {
  setGameState(state, { gameState }) {
    state.gameState = gameState
  },
  setPlayerState(state, { playerState }) {
    state.playerState = playerState
  },
  setPlayerId(state, playerId) {
    state.playerId = playerId
  },
  setScore(state, { scoreId, score }) {
    state.scores[scoreId] = score
  },
  setPlayers(state, players) {
    state.players = players
  },
  setError(state, error) {
    state.error = error
  },
  setMode(state, { mode }) {
    state.mode = mode
  },
  haveBothPlayersSetIslands(state, haveBothPlayersSetIslands) {
    state.haveBothPlayersSetIslands = haveBothPlayersSetIslands
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}