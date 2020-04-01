import { db } from '../db';

// eslint-disable-next-line
export const getQuestions = async () => {
  const snapshot = await db.collection('questions').get();
  return snapshot.docs.map((doc) => doc.data());
};
