import Vue from "vue";
import App from "./App";
import router from "./router/index";
import moment from "moment";
import Axios from 'axios'

import PaperDashboard from "./plugins/paperDashboard";
import "vue-notifyjs/themes/default.css";

Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('MM/DD/YYYY hh:mm:ss')
  }
});

Vue.filter('formatCurrent', function(value) {
  if (value) {
    return `R$ ${value}`
  }
});

Vue.prototype.$http = Axios;

Vue.use(PaperDashboard);

/* eslint-disable no-new */
new Vue({
  router,
  render: h => h(App)
}).$mount("#app");
