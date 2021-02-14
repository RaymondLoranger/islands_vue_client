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
      this.setPosition({ islandId, position }) // payload is only argument
      this.getChannel.push('position_island', { islandId, position })
    },
    getData(e) {
      const data = e.dataTransfer.getData('text')
      const { islandId, offsetX, offsetY } = JSON.parse(data)
      let { x, y } = this.locateDrop(e) // drop may be over island or board
      return { islandId, x, y, offsetX, offsetY }
    }
  }
}
