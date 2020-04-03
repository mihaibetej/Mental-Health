// import firebase from 'firebase/firebase';
import firebase, { db } from '../db';
import { getDateKey } from '../utils/helpers';
import answers from '../screens/answers';

export const usersSubscribe = (cb) =>
  db.collection('users').onSnapshot((snapshot) => {

    let us = []
    snapshot.forEach(doc => {
      us.push(doc.data())
    })

    cb(us)
  })

export const userSubscribe = (userId, cb) => {
  db.collection('users').doc(userId)
    .onSnapshot((doc) => {
      cb(doc.data())
    })
}

export const answersSubscribe = (userId, cb) =>
  db.collection('users').doc(userId)
    .collection('answers').onSnapshot((snapshot) => {
      let as = []
      snapshot.forEach(doc => {
        as.push(doc.data())
      })

      cb(as)
    })

// eslint-disable-next-line
export const setAnswers = async (values, userId) =>
  db
    .collection('users')
    .doc(userId)
    .collection('answers')
    .doc(getDateKey())
    .set({
      created: firebase.firestore.FieldValue.serverTimestamp(),
      items: values,
    });

export const getUserAnswers = async (userId) => {
  const answers = await db
    .collection('users')
    .doc(userId)
    .collection('answers')
    .doc(getDateKey())
    .get();

  return answers.data() || [];
};


