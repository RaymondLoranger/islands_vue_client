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
      `<span style="color:#ff0088;">${message.sender}</span>:` :
      `<span style="color:#1a1aff;">${message.sender}</span>:`
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
  min-height: calc(3 * 96vw / 12);
  max-height: calc(3 * 96vw / 12);
  overflow-y: scroll;
  font-size: 1.4vw;
}
ul#messages .sender {
  font-weight: normal;
}
ul#messages .body {
  font-weight: normal;
}
.list-group-item {
  position: relative;
  display: block;
  padding: 2px 3px;
  margin-bottom: -1px;
  background-color: #fff;
  border: 1px solid #ddd;
}
</style>