import { mapGetters, mapActions } from 'vuex'

function gridPosition (gridColumnStart, gridRowStart) {
  return { gridColumnStart, gridRowStart }
}

export default {
  name: 'listener',
  computed: mapGetters(['getChannel']),
  methods: {
    ...mapActions(['setPosition']),
    dragEnter(e) {
      e.preventDefault()
    },
    dragOver(e) {
      e.preventDefault()
    },
    dragLeave(e) {
      e.preventDefault()
    },
    drop(e) {
      e.preventDefault()
      const { islandId, x, y, offsetX, offsetY } = this.getData(e)
      const position = gridPosition(x - offsetX, y - offsetY)
      // Enable stack orders of child squares.
      document.getElementById(islandId).style.zIndex = 'auto'
      this.setPosition({ islandId, position }) // Payload must be only argument.
      this.getChannel.push('position_island', { islandId, position })
    },
    getData(e) {
      const data = e.dataTransfer.getData('text')
      const { islandId, offsetX, offsetY } = JSON.parse(data)
      let { x, y } = this.locateDrop(e)
      return { islandId, x, y, offsetX, offsetY }
    }
  }
}
