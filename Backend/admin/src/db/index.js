import firebase from 'firebase/firebase';
import config from '../config';

firebase.initializeApp(config);

export const db = firebase.firestore();
export const storageRef = firebase.storage().ref();
export const firebaseAuth = firebase.auth;

export default firebase;
