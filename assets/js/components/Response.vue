<template>
  <p id="response" class="alert alert-info" v-html="getResponse"/>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Response',
  computed: mapGetters(['getResponse'])
}
</script>
