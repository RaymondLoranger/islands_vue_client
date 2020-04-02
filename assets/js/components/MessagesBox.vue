<template>
  <div class="box">
    <Messages/>
    <ChatForm/>
  </div>
</template>

<script>
import Messages from './Messages.vue'
import ChatForm from './ChatForm.vue'

export default {
  name: 'MessagesBox',
  components: {
    Messages,
    ChatForm
  }
}
</script>

<style scoped>
.box {
  display: flex;
  flex-direction: column;
  align-content: space-between;
}
</style>
