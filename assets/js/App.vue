<template>
  <div>
    <h1>{{ title }}</h1>
    <p>{{ greeting() }}</p>
    <div class="across">
      <BoardBox :board="board" :positions="positions"/>
      <GuessesBox/>
    </div>
  </div>
</template>

<script>
import BoardBox from './components/BoardBox.vue'
import GuessesBox from './components/GuessesBox.vue'
import { Socket, Presence } from "phoenix"

export default {
  components: {
    BoardBox,
    GuessesBox
  },
  data: () => {
    return {
      error: '',
      title: '--- The Game of Islands ---',
      board: { islands: {}, misses: [] }, // empty board
      positions: { // See Functional Web Development, page 13
        atoll: { row: 1, col: 1 },
        dot: { row: 9, col: 9 },
        l_shape: { row: 3, col: 7 },
        s_shape: { row: 6, col: 2 },
        square: { row: 9, col: 5 }
      },
      player: {
        name: 'Adam',
        gender: 'M',
        hits: 4,
        misses: 7,
        forested: ['a', 'l', 'd']
      },
      opponent: {
        name: 'Eve',
        gender: 'F',
        hits: 6,
        misses: 11,
        forested: ['s', 'q']
      }
    }
  },
  methods: {
    greeting: () => 'Howdy, Sir!',
    setPosition(island) {
      if (typeof island !== 'undefined') {
        this.positions[island.type] = island.coords.reduce((acc, coord) => ({
          row: Math.min(acc.row, coord.row),
          col: Math.min(acc.col, coord.col)
        }))
      }
    },
    joinChannel(authToken, gameName) {
      const socket = new Socket('/socket', { params: { token: authToken } })
      socket.connect()
      this.channel = socket.channel(`games:${gameName}`, {})
      this.channel.on('game_tally', tally => {
        const { board } = tally
        const { islands } = board
        const { atoll, dot, l_shape, s_shape, square} = islands
        this.setPosition(atoll)
        this.setPosition(dot)
        this.setPosition(l_shape)
        this.setPosition(s_shape)
        this.setPosition(square)
        this.board = board
      })
      this.channel
        .join()
        .receive('ok', response => {
          console.log(`Joined ${gameName} 😊`)
        })
        .receive('error', response => {
          this.error = `Joining ${gameName} failed 🙁`
          console.log(this.error, response)
        })
    }
  },
  created() {
    const gameContainer = this.$parent.$el
    const { authToken, gameName } = gameContainer.dataset
    this.joinChannel(authToken, gameName)
  }
}
</script>

<style>
body {
  background: Khaki;
}
.across {
  display: flex;
  flex-direction: row;
}
.square {
  background:Chocolate;
}
.hit {
  background: ForestGreen;
}
.missed {
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
