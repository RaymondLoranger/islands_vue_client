export default {
  name: 'boardListener',
  methods: {
    locateDrop(e) { // The drop target element is some board square.
      const { square } = e.target.dataset
      const x = (square % 10 === 0) ? 10 : square % 10
      const y = Math.ceil(square / 10)
      return { x, y } // Return grid position of cursor on drop event.
    }
  }
}