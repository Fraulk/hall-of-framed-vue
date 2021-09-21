import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import vuetify from './plugins/vuetify';
import "./plugins/firebase";
import router from './router'

Vue.config.productionTip = false
Vue.prototype.$axios = axios

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
