// import firebase from 'firebase/firebase';
import firebase, { db } from '../db';
import { getDateKey } from '../utils/helpers';

// eslint-disable-next-line
export const setAnswers = async (values, userId) => {
  db.collection('users')
    .doc(userId)
    .collection('answers')
    .doc(getDateKey())
    .set({
      created: firebase.firestore.FieldValue.serverTimestamp(),
      items: values,
    });

  // console.log('setAnswers -> answers', answers);
};
