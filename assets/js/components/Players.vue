<template>
  <div class="panel panel-default">
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
import { mapGetters } from 'vuex'

export default {
  name: 'Players',
  computed: mapGetters(['getPlayers']),
  methods: {
    id: player => player.player_id.slice(-1),
    hits: player => `${player.hits} hit${player.hits == 1 ? '' : 's'}`,
    name: player =>
      player.gender === 'f' ?
      `<span style="color:#ff0088;">${player.player_name}</span>` :
      `<span style="color:#1a1aff;">${player.player_name}</span>`
  }
}
</script>

<style scoped>
ul#players {
  min-height: calc(1 * 96vw / 12);
  max-height: calc(1 * 96vw / 12);
}
ul#players .id {
  font-size: 1.6vw;
  vertical-align: middle;
}
ul#players .name {
  font-size: 1.6vw;
  vertical-align: middle;
}
ul#players .hits  {
  font-size: 1.6vw;
  margin-right: 3px;
  vertical-align: middle;
  float: right;
}
.list-group-item {
  position: relative;
  display: block;
  padding: 2px 3px;
  margin-bottom: -1px;
  background-color: #fff;
  border: 1px solid #ddd;
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