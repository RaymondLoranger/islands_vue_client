<template>
  <div id="app">
    <GameUrl/>
    <Response/>
    <Directive/>
    <Error/>
    <div class="grid">
      <BoardScore class="board-score"/>
      <GuessesScore class="guesses-score"/>
      <Players class="players"/>

      <BoardBox class="board-box"/>
      <GuessesBox class="guesses-box"/>
      <Messages class="messages"/>

      <BoardControl class="board-control"/>
      <GuessesControl class="guesses-control"/>
      <ChatForm class="chat-form"/>
    </div>
  </div>
</template>

<script>
import BoardBox from './components/BoardBox.vue'
import BoardControl from './components/BoardControl.vue'
import BoardScore from './components/BoardScore.vue'
import ChatForm from './components/ChatForm.vue'
import Directive from './components/Directive.vue'
import Error from './components/Error.vue'
import GameUrl from './components/GameUrl.vue'
import GuessesBox from './components/GuessesBox.vue'
import GuessesControl from './components/GuessesControl.vue'
import GuessesScore from './components/GuessesScore.vue'
import Messages from './components/Messages.vue'
import Players from './components/Players.vue'
import Response from './components/Response.vue'
import { Socket, Presence } from 'phoenix'
import { mapActions } from 'vuex'

export default {
  name: 'App',
  components: {
    BoardBox,
    BoardControl,
    BoardScore,
    ChatForm,
    Directive,
    Error,
    GameUrl,
    GuessesBox,
    GuessesControl,
    GuessesScore,
    Messages,
    Players,
    Response
  },
  methods: {
    ...mapActions([
      'pushMessage',
      'setChannel',
      'setDirective',
      'setError',
      'setGameState',
      'setGameUrl',
      'setGuessesHits',
      'setGuessesMisses',
      'setHits',
      'setMisses',
      'setMode',
      'setPlayerId',
      'setPlayers',
      'setPlayerState',
      'setPosition',
      'setPositions',
      'setResponse',
      'setScore'
    ]),
    joinChannel(authToken, gameName, gameUrl, playerId) {
      const socket = new Socket('/socket', { params: { token: authToken } })
      socket.connect()
      const channel = socket.channel(`games:${gameName}`, {})
      channel.on('island_hits', hits => this.setHits(hits))
      channel.on('island_misses', misses => this.setMisses(misses))
      channel.on('guesses_hits', hits => this.setGuessesHits(hits))
      channel.on('guesses_misses', misses => this.setGuessesMisses(misses))
      channel.on('chat_message', message => this.pushMessage(message))
      channel.on('response', response => this.setResponse(response))
      channel.on('directive', directive => this.setDirective(directive))
      channel.on('error', error => this.setError(error))
      channel.on('set_mode', mode => this.setMode(mode))
      channel.on('game_state', state => this.setGameState(state))
      channel.on('player_state', state => this.setPlayerState(state))

      channel.on('island_positions', positions => {
        this.setPositions(positions)
      })

      channel.on('island_position', position => {
        this.setPosition(position)
      })

      const presences = new Presence(channel)
      presences.onSync(_ => this.setPlayers(presences))

      channel.on('board_score', score => {
        this.setScore({ scoreId: 'board', score }) // must precede setPlayers
        this.setPlayers(presences)
      })

      channel.on('guesses_score', score => {
        this.setScore({ scoreId: 'guesses', score }) // must precede setPlayers
        this.setPlayers(presences)
      })

      channel.join()
        .receive('ok', _response => {
          this.setPlayerId(playerId)
          this.setGameUrl(gameUrl)
          this.setChannel(channel)
          console.log(`Joined ${gameName} 😊`)
        })
        .receive('error', error => {
          this.setError(error)
          console.log('error:', error)
        })
    }
  },
  created() {
    const joinChannelData = document.querySelector('#join-channel-data')
    const { authToken, gameName, gameUrl, playerId } = joinChannelData.dataset
    document.title = gameName
    joinChannelData.remove()
    this.joinChannel(authToken, gameName, gameUrl, playerId)
  }
}
</script>

<style scoped>
.grid {
  /* border: 2px var(--background-color) groove; */
  /* border-radius: 4px; */
  display: grid;
  margin: 25px auto 15px;
  grid-template-columns: 2fr 2fr 1fr;
  grid-template-rows: auto 1fr auto;
  grid-gap: 1vw;
  align-items: stretch;
  justify-items: stretch;
}
.board-score {
  grid-row: 1 / span 1;
  grid-column: 1 / span 1;
}
.guesses-score {
  grid-row: 1 / span 1;
  grid-column: 2 / span 1;
}
.players {
  grid-row: 1 / span 1;
  grid-column: 3 / span 1;
}
.board-box {
  grid-row: 2 / span 1;
  grid-column: 1 / span 1;
}
.guesses-box {
  grid-row: 2 / span 1;
  grid-column: 2 / span 1;
}
.messages {
  grid-row: 2 / span 1;
  grid-column: 3 / span 1;
}
.board-control {
  align-self: center;
  grid-row: 3 / span 1;
  grid-column: 1 / span 1;
}
.guesses-control {
  align-self: center;
  grid-row: 3 / span 1;
  grid-column: 2 / span 1;
}
.chat-form {
  align-self: center;
  grid-row: 3 / span 1;
  grid-column: 3 / span 1;
}

@media (max-width: 900px) { /* styles for widths <= 900px */
  .grid {
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: repeat(9, auto);
  }
  .board-score {
    grid-row: 1 / span 1;
    grid-column: 2 / span 1;
  }
  .board-box {
    grid-row: 2 / span 1;
    grid-column: 2 / span 1;
  }
  .board-control {
    justify-self: center;
    grid-row: 3 / span 1;
    grid-column: 2 / span 1;
  }
  .guesses-score {
    grid-row: 4 / span 1;
    grid-column: 2 / span 1;
  }
  .guesses-box {
    grid-row: 5 / span 1;
    grid-column: 2 / span 1;
  }
  .guesses-control {
    justify-self: center;
    grid-row: 6 / span 1;
    grid-column: 2 / span 1;
  }
  .players {
    grid-row: 7 / span 1;
    grid-column: 2 / span 1;
  }
  .messages {
    grid-row: 8 / span 1;
    grid-column: 2 / span 1;
  }
  .chat-form {
    grid-row: 9 / span 1;
    grid-column: 2 / span 1;
  }
}
</style>

<style>
#join-channel-data {
  display: none;
}
.across {
  display: flex;
  flex-direction: row;
  justify-content: center;
}
.square {
  background:Chocolate;
}
.hit {
  background: ForestGreen;
  animation: blinker 0.1s linear 1;
}
.miss {
  background: DodgerBlue;
  animation: blinker 0.1s linear 1;
}
@keyframes blinker {
  50% { opacity: 0; }
}
.visible {
  visibility: visible;
}
.hidden {
  visibility: hidden;
}
.draggable {
  cursor: move;
}
.freeze-events {
  pointer-events: none;
}
.freeze-cursor {
  cursor: not-allowed;
}
.score-box {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.score-box > p {
  font-family: 'Courier New', Courier, 'Consolas', monospace;
  font-size: calc(9px + 0.9vw);
  font-weight: 600;
  margin: 2px;
  white-space: nowrap;
}
@media (max-width: 768px) { /* styles for widths <= 768px */
  .score-box > p {
    font-size: calc(11px + 0.9vw);
  }
}
.score-box .forested {
  background: ForestGreen;
  color: White;
}
.score-box img {
  height: calc(9px + 0.9vw);
  width: calc(9px + 0.9vw);
}
.grid10x10 {
  box-sizing: content-box;
  margin: 0;
  position: relative;
  width: calc(var(--ss) * 10 + 9px);
  height: calc(var(--ss) * 10 + 9px);
  display: grid;
  grid-template: repeat(10, 1fr) / repeat(10, 1fr);
  grid-gap: 1px;
  border: 1px solid White;
  background: White;
}
.control {
  display: flex;
  align-items: center;
  justify-content: space-evenly;
}
.control-item {
  margin: 2px 3px 2px;
}
div.control {
  white-space: nowrap;
}
.tag {
  background: LightGrey;
  text-align: center;
  vertical-align: middle;
  line-height: var(--ss);
  font-weight: 600;
  font-size: 2vw;
}
@media (max-width: 768px) { /* styles for widths <= 768px */
  .tag {
    font-size: 4vw;
  }
}
</style>
