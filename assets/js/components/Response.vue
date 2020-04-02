<template>
  <p class="alert alert-info">{{ getResponse }}</p>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Response',
  computed: mapGetters(['getResponse'])
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
  font-weight: 550;
  /* text-transform: uppercase; */
}
</style>