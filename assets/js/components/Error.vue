<template>
  <p id="error" class="alert alert-danger" v-html="getError"/>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Error',
  computed: mapGetters(['getError'])
}
</script>
