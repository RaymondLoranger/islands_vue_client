<template>
  <div class="panel panel-default">
    <div class="panel-heading">What's Up?</div>
    <div class="panel-body">
      <ul id="messages" ref="messages" class="list-group">
        <li class="list-group-item"
            v-for="(message, index) in getMessages"
            :key="index">
          <span class="sender" v-html="sender(message)"/>
          <span class="body">{{ message.body }}</span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Messages',
  computed: mapGetters(['getMessages']),
  methods: {
    sender: message =>
      message.gender === 'f' ?
      `<span class="female">${message.sender}</span>:` :
      `<span class="male">${message.sender}</span>:`
  },
  watch: {
    getMessages(_newValue, _oldValue) {
      this.$nextTick(_ => {
        // DOM is now updated
        const messageList = this.$refs.messages
        messageList.scrollTop = messageList.scrollHeight
      })
    }
  }
}
</script>

<style scoped>
ul#messages {
  min-height: calc(11 * var(--ss) + 11px);
  max-height: calc(11 * var(--ss) + 11px);
  overflow-y: scroll;
  font-size: calc(6px + 0.9vw);
}
ul#messages .sender {
  font-weight: normal;
}
ul#messages .body {
  font-weight: normal;
}
</style>