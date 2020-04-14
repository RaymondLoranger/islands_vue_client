<template>
  <p class="alert alert-success" v-html="getDirective"/>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Directive',
  computed: mapGetters(['getDirective'])
}
</script>

<style scoped>
.alert {
  padding: 1px;
  margin: 1px;
  text-align: center;
  border: none;
  background: none;
  font-size: 1.25em;
  font-weight: 550;
  /* text-transform: uppercase; */
}
</style>