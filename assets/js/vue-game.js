import Vue from 'vue'
import App from './App.vue'
import store from './store' // './store/index.js' assumed...

const mountingPoint = '#mounting-point'

if (document.querySelector(mountingPoint)) {
  new Vue({
    store,
    render: h => h(App)
  }).$mount(mountingPoint)
}

// The provided element merely serves as a mounting point.
// Unlike in Vue 1.x, the mounted element will be replaced
// with Vue-generated DOM in all cases.
