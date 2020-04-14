<template>
  <form id="chat-form" @submit.prevent="sendChat">
    <div class="input-group">
      <input id="chat-input" type="text" class="form-control"
             :disabled="isGameNew" v-model="chatMessage">
      <span class="input-group-btn">
        <button id="chat-button" class="btn btn-primary" @click="sendChat"
                :disabled="!chatMessage">
          <i class="fa fa-comment"></i>
        </button>
      </span>
    </div>
  </form>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ChatForm',
  data() {
    return {
      chatMessage: ''
    }
  },
  computed: mapGetters(['getChannel', 'isGameNew']),
  methods: {
    sendChat(_event) {
      if (this.chatMessage) {
        this.getChannel.push('chat_message', { body: this.chatMessage })
        this.chatMessage = ''
      }
    }
  }
}
</script>
