<template>
  <p id="directive" class="alert alert-success" v-html="getDirective"/>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Directive',
  computed: mapGetters(['getDirective'])
}
</script>
