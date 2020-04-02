<template>
  <form id="chat-form" @submit.prevent="sendChat">
    <div class="input-group">
      <input id="chat-input"
              type="text"
              class="form-control"
              v-model="chatMessage">
      <span class="input-group-btn">
        <button id="chat-button"
                class="btn btn-primary"
                :disabled="!chatMessage"
                @click="sendChat">
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
  computed: mapGetters(['getChannel']),
  methods: {
    sendChat(_event) {
      if (this.chatMessage) {
        this.getChannel.push('new_chat_message', { body: this.chatMessage })
        this.chatMessage = ''
      }
    }
  }
}
</script>
