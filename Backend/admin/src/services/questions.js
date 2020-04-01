import { db } from '../db';

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
export const getQuestions = async () => {
  const snapshot = await db.collection('questions').get();
  return snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));
};

export const getQuestionById = async (id) => {
  const question = await db
    .collection('questions')
    .doc(id)
    .get()
    // eslint-disable-next-line consistent-return
    .then((doc) => {
      if (doc.exists) {
        return doc.data();
      }
    })
    .catch((e) => {
      console.log(`Error getting data for questions with id ${id}`, e);
    });

  return question;
};

export const createQuestion = async (body, answers = defaultAnswers) => {
  await db.collection('questions').add({
    body,
    answers,
  });
};

export const updateQuestion = async (id, body) => {
  await db.collection('questions').doc(id).update({
    body,
  });
};

export const deleteQuestion = async (id) => {
  await db.collection('questions').doc(id).delete();
};
