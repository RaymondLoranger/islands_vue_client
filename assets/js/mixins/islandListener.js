import { mapGetters } from 'vuex'

function offset(classAttr) { // e.g. 'c2' => { offsetX: 2, offsetY: 1 }
  const offsetX = classAttr.charCodeAt(0) - 'a'.charCodeAt(0)
  const offsetY = classAttr.charCodeAt(1) - '1'.charCodeAt(0)
  return { offsetX, offsetY }
}

function addOutline(islandId) {
  for (const square of document.querySelectorAll(`#${islandId} .draggable`)) {
    square.classList.add('dragging')
  }
}

function removeOutline(islandId) {
  for (const square of document.querySelectorAll(`#${islandId} .dragging`)) {
    square.classList.remove('dragging')
  }
}

export default {
  name: 'islandListener',
  computed: mapGetters(['getDimension', 'getPosition']),
  methods: {
    dragStart(e) {
      this.setData(e)
      addOutline(e.target.id)
      // Avoid "ghost" squares while dragging island and cover other islands.
      e.target.style.zIndex = 2
      setTimeout(_ => e.target.classList.add('hidden'), 0)
    },
    dragEnd(e) {
      e.target.classList.remove('hidden')
      removeOutline(e.target.id)
      // Restore stack orders of island and its child squares.
      e.target.style.zIndex = 'auto'
    },
    dragHalt(e) {
      e.preventDefault()
      e.stopPropagation()
    },
    setData(e) {
      const { squaresAcross, squaresDown } = this.getDimension(e.target.id)
      const squareWidth = Math.floor(e.target.clientWidth / squaresAcross)
      const squareHeight = Math.floor(e.target.clientHeight / squaresDown)
      const offsetX = Math.floor(e.offsetX / squareWidth)
      const offsetY = Math.floor(e.offsetY / squareHeight)
      const data = { islandId: e.target.id, offsetX, offsetY }
      e.dataTransfer.setData('text', JSON.stringify(data))
    },
    locateDrop(e) { // The drop target element is some island square.
      const { offsetX, offsetY } = offset(e.target.classList[0])
      const islandId = e.target.parentElement.id
      const { gridColumnStart, gridRowStart } = this.getPosition(islandId)
      const x = gridColumnStart + offsetX
      const y = gridRowStart + offsetY
      return { x, y } // Return grid position of cursor on drop event.
    }
  }
}