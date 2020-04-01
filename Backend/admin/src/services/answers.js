// import firebase from 'firebase/firebase';
import firebase, { db } from '../db';
import { getDateKey } from '../utils/helpers';

const defaultAnswers = [
  {
    title: 'Bad',
    value: 0,
  },
  {
    title: 'Mmm',
    value: 1,
  },
  {
    title: 'Ok',
    value: 2,
  },
  {
    title: 'Good',
    value: 3,
  },
  {
    title: 'Awesome',
    value: 4,
  },
];

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
