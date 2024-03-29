import firebaseConfig from "../../firebase";
import firebase from "firebase/compat/app"
import "firebase/compat/database"
import Vue from "vue";

const firebaseApp = firebase.initializeApp(firebaseConfig);
const db = firebaseApp.database();

Vue.prototype.$db = db;

export default db;
