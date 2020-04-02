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
/* ul#messages {
  min-height: 200px;
  max-height: 200px;
  overflow-y: scroll;
  font-size: 0.8em;
} */
ul#messages {
  /* height: 128px; */
  /* min-height: 200px;
  max-height: 200px; */
  /* min-height: 20vw;
  max-height: 30vw; */
  min-height: calc(3 * 96vw / 12);
  max-height: calc(3 * 96vw / 12);
  overflow-y: scroll;
  font-size: 1.2vw;
  /* font-size: 2vw; */
}
/* @media (min-width: 650px) { */ /* styles for browsers larger than 650px */
  /* ul#messages {
    height: 182px;
    font-size: 1em;
  }
} */
/* @media (min-width: 990px) { */ /* styles for browsers larger than 990px */
  /* ul#messages {
    height: 298px;
    font-size: 1em;
  }
} */
/* @media (min-width: 1200px) { */ /* styles for browsers larger than 1200px */
  /* ul#messages {
    height: 405px;
    font-size: 1em;
  }
} */
ul#messages .message-sender {
  font-weight: bold;
}
ul#messages .message-body {
  font-weight: 550;
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