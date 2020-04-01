import { db } from '../db';

const defaultAnswers = [
  {
    title: 'Bad',
    value: 0
  },
  {
    title: 'Mmm',
    value: 1
  },
  {
    title: 'Ok',
    value: 2
  },
  {
    title: 'Good',
    value: 3
  },
  {
    title: 'Awesome',
    value: 4
  }
];

// eslint-disable-next-line
export const getQuestions = async () => {
  const snapshot = await db.collection('questions').get();
  return snapshot.docs.map((doc) => doc.data());
};

export const createQuestion = async (body, answers = defaultAnswers) => {
  await db.collection('questions').add({
    body,
    answers,
  });
};
