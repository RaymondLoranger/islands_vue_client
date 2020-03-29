<template>
  <div>
    <GameUrl/>
    <Response/>
    <Directive/>
    <Error/>
    <div class="grid">
      <BoardScore class="left score"/>
      <GuessesScore class="center score"/>
      <Players class="right players"/>

      <BoardBox class="left box"/>
      <GuessesBox class="center box"/>
      <Messages class="right messages"/>

      <StartControl class="left control"/>
      <PlayControl class="center control"/>
      <ChatForm class="right chat-form"/>
    </div>
  </div>
</template>

<script>
import BoardBox from './components/BoardBox.vue'
import BoardScore from './components/BoardScore.vue'
import ChatForm from './components/ChatForm.vue'
import Directive from './components/Directive.vue'
import Error from './components/Error.vue'
import GameUrl from './components/GameUrl.vue'
import GuessesBox from './components/GuessesBox.vue'
import GuessesScore from './components/GuessesScore.vue'
import Messages from './components/Messages.vue'
import PlayControl from './components/PlayControl.vue'
import Players from './components/Players.vue'
import Response from './components/Response.vue'
import StartControl from './components/StartControl.vue'
import { Socket, Presence } from "phoenix"
import { mapActions } from 'vuex'

export default {
  name: 'App',
  components: {
    BoardBox,
    BoardScore,
    ChatForm,
    Directive,
    Error,
    GameUrl,
    GuessesBox,
    GuessesScore,
    Messages,
    PlayControl,
    Players,Response,
    StartControl
  },
  methods: {
    ...mapActions([
      'pushMessage',
      'setBoardScore',
      'setChannel',
      'setDirective',
      'setError',
      'setGameState',
      'setGameUrl',
      'setGuessesHits',
      'setGuessesMisses',
      'setGuessesScore',
      'setHits',
      'setMisses',
      'setPlayerId',
      'setPlayers',
      'setPositions',
      'setResponse'
    ]),
    joinChannel(authToken, gameName, gameUrl, playerId) {
      const socket = new Socket('/socket', { params: { token: authToken } })
      socket.connect()
      const channel = socket.channel(`games:${gameName}`, {})
      channel.on('island_hits', hits => this.setHits(hits))
      channel.on('island_misses', misses => this.setMisses(misses))
      channel.on('guesses_hits', hits => this.setGuessesHits(hits))
      channel.on('guesses_misses', misses => this.setGuessesMisses(misses))
      channel.on('new_chat_message', message => this.pushMessage(message))
      channel.on('response', response => this.setResponse(response))
      channel.on('directive', directive => this.setDirective(directive))
      channel.on('error', error => this.setError(error))
      channel.on('game_state', state => this.setGameState(state))
      let presences = {}

      channel.on('island_positions', positions => {
        this.setPositions(positions)
      })

      channel.on('presence_state', state => {
        presences = Presence.syncState(presences, state)
        this.setPlayers(presences)
      })

      channel.on('presence_diff', diff => {
        presences = Presence.syncDiff(presences, diff)
        this.setPlayers(presences)
      })

      channel.on('board_score', score => {
        this.setBoardScore(score) // Must precede setPlayers.
        this.setPlayers(presences)
      })

      channel.on('guesses_score', score => {
        this.setGuessesScore(score) // Must precede setPlayers.
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
    this.joinChannel(authToken, gameName, gameUrl, playerId)
  }
}
</script>

<style scoped>
.grid {
  border: 1px red solid;
  display: grid;
  width: 96vw;
  margin: 15px auto;
  grid-template-columns: repeat(12, 1fr);
  grid-template-rows: 2fr repeat(5 calc(96vw / 12)) 1fr;
  grid-gap: 3px;
  align-items: stretch;
  justify-items: stretch;
}
.left {
  grid-column: 1 / span 5;
  /* align-self: stretch; */
}
.center {
  grid-column: 6 / span 5;
  /* align-self: stretch; */
}
.right {
  grid-column: 11 / span 2;
  /* align-self: stretch; */
}
.score {
  grid-row: 1 / span 2;
  /* justify-self: stretch; */
}
.box {
  grid-row: 3 / span 5;
}
.control {
  grid-row: 8 / span 1;
}
.players {
  grid-row: 1 / span 2;
  /* align-self: start; */
}
.messages {
  grid-row: 3 / span 5;
  /* align-self: stretch; */
}
.chat-form {
  grid-row: 8 / span 1;
  /* align-self: center; */
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
}
.miss {
  background: DodgerBlue;
}

/* Draggable element classes
–––––––––––––––––––––––––––––––––––––––––––––––––– */

.hold {
  border: 2px dashed blue;
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
</style>
