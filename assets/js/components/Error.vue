<template>
  <p class="alert alert-danger" v-html="getError"/>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Error',
  computed: mapGetters(['getError'])
}
</script>

<style scoped>
.alert {
  padding: 3px;
  margin-bottom: 3px;
  text-align: center;
  border: none;
  background: none;
  font-size: 1.25em;
  font-weight: 600;
}
</style>