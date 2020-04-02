import Vue from 'vue'
import App from './App.vue'
import store from './store' // './store/index.js' assumed...

if (document.querySelector('#mounting-point')) {
  new Vue({
    store,
    el: '#mounting-point',
    template: '<App/>',
    components: { App }
  })
}

// The provided element merely serves as a mounting point.
// Unlike in Vue 1.x, the mounted element will be replaced
// with Vue-generated DOM in all cases.
