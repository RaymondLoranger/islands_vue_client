<template>
  <div class="container">
    <p>
      <span>Eve <img src="/images/female.png" height="22" width="22"></span>
    </p>
    <p><span>Hits:  4   Misses:  7</span></p>
    <p><span>Forested => A D L S Q</span></p>
  </div>
</template>

<script>
export default {
  name: 'Player'
}
</script>

<style scoped>
.container {
  margin: auto;
}
p {
  font-family:'Courier New', Courier, monospace;
  font-size: 1.7rem;
  font-weight: 600;
}
</style>
