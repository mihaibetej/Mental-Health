import firebase from 'firebase/firebase';
import config from '../config';

firebase.initializeApp(config);

export const db = firebase.firestore();
export const firebaseAuth = firebase.auth;

export default firebase;