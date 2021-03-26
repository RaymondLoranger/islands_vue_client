<template>
  <div id="players-group" class="panel panel-default">
    <div class="panel-heading">Who's Playing</div>
    <div class="panel-body">
      <ul id="players" class="list-group">
        <transition-group name="player-appear">
          <li class="list-group-item"
              v-for="player in getPlayers"
              :key="id(player)">
            <span class="id">{{ id(player) }}.</span>
            <span class="name" v-html="name(player)"/>
            <span class="hits">{{ hits(player) }}</span>
          </li>
        </transition-group>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'Players',
  computed: mapGetters(['getChannel', 'getPlayers', 'isGameOver']),
  methods: {
    ...mapActions(['setGameState']),
    id: player => player.player_id.slice(-1),
    hits: player => `${player.hits} hit${player.hits == 1 ? '' : 's'}`,
    name: player =>
      player.gender === 'f' ?
      `<span class="female">${player.player_name}</span>` :
      `<span class="male">${player.player_name}</span>`
  },
  watch: {
    getPlayers(newPlayers, oldPlayers) {
      if (newPlayers.length < oldPlayers.length && !this.isGameOver) {
        this.setGameState('game_over')
        this.getChannel.push('opponent_left', {})
      }
    }
  }
}
</script>

<style scoped>
ul#players {
  min-height: calc(14px + 4vw);
  max-height: calc(14px + 4vw);
  font-size: calc(7px + 1vw);
}
ul#players .id {
  font-weight: normal;
}
ul#players .name {
  font-weight: normal;
}
ul#players .hits  {
  font-weight: normal;
  margin-right: 3px;
  float: right;
}
.player-appear-enter-active {
  transition: all 2.5s
}
.player-appear-leave-active {
  transition: all 0.75s
}
.player-appear-enter, .player-appear-leave-active {
  opacity: 0.1;
}
</style>