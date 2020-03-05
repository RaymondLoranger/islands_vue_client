<template>
  <div class="panel panel-default">
    <div class="panel-heading">What's Up?</div>
    <div class="panel-body">
      <ul id="messages" ref="messages" class="list-group">
        <li class="list-group-item"
            v-for="(message, index) in getMessages"
            :key="index">
          <span class="message-sender">{{ message.sender }}:</span>
          <span class="message-body">{{ message.body }}</span>
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
  watch: {
    getMessages(_newValue, _oldValue) {
      this.$nextTick(() => {
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
  height: 128px;
  overflow-y: scroll;
  font-size: 0.8em;
}
@media (min-width: 650px) { /* styles for browsers larger than 650px */
  ul#messages {
    height: 182px;
    font-size: 1em;
  }
}
@media (min-width: 990px) { /* styles for browsers larger than 990px */
  ul#messages {
    height: 298px;
    font-size: 1em;
  }
}
@media (min-width: 1200px) { /* styles for browsers larger than 1200px */
  ul#messages {
    height: 405px;
    font-size: 1em;
  }
}
ul#messages .message-sender {
  font-weight: bold;
}
ul#messages .message-body {
  font-weight: 550;
}
</style>