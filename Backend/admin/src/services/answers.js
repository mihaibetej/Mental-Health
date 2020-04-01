import firebase from 'firebase/firebase';
import { db } from '../db';

// eslint-disable-next-line
export const setAnswers = async (values) => {
  const answers = await db
    .collection('users')
    .doc('H5Vrh55coIzNDCPNrNQ8')
    .collection('answers')
    .doc(firebase.firestore.FieldValue.serverTimestamp());

  console.log('setAnswers -> answers', answers);
};
