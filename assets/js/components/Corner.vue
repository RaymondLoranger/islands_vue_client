<template>
  <div class="corner"/>
</template>

<script>
export default {
  name: 'Corner'
}
</script>

<style scoped>
.corner {
  box-sizing: content-box;
  background: LightGrey;
  width: var(--ss);
  height: var(--ss);
}
.top-left {
  border-top: 1px solid White;
  border-left: 1px solid White;
}
.top-right {
  border-top: 1px solid White;
  border-right: 1px solid White;
}
.bottom-left {
  border-bottom: 1px solid White;
  border-left: 1px solid White;
}
.bottom-right {
  border-bottom: 1px solid White;
  border-right: 1px solid White;
}
</style>
