import { mapGetters, mapActions } from 'vuex'

function gridPosition (gridColumnStart, gridRowStart) {
  return { gridColumnStart, gridRowStart }
}

function isValidPosition (position, dimension) {
  const { gridColumnStart, gridRowStart } = position
  const { squaresAcross, squaresDown } = dimension
  const xStart = gridColumnStart
  const xEnd = gridColumnStart + squaresAcross - 1
  const yStart = gridRowStart
  const yEnd = gridRowStart + squaresDown - 1
  return (1 <= xStart && xEnd <= 10) && (1 <= yStart && yEnd <= 10)
}

export default {
  name: 'listener',
  computed: mapGetters(['getDimension']),
  methods: {
    ...mapActions(['position']),
    dragEnter (e) {
      e.preventDefault()
    },
    dragOver (e) {
      e.preventDefault()
    },
    dragLeave (e) {
      e.preventDefault()
    },
    drop (e) {
      e.preventDefault()
      const { islandId, x, y, offsetX, offsetY } = this.getData(e)
      const position = gridPosition(x - offsetX, y - offsetY)
      const dimension = this.getDimension(islandId)
      if (isValidPosition(position, dimension)) {
        this.position({ islandId, position }) // payload must be only argument
      }
    },
    getData (e) {
      const data = e.dataTransfer.getData('text')
      const { islandId, offsetX, offsetY } = JSON.parse(data)
      let { x, y } = this.locateDrop(e)
      return { islandId, x, y, offsetX, offsetY }
    }
  }
}
