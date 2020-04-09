import { db } from '../db';

const defaultAnswers = [
  {
    title: 'foarte mult',
    value: 0,
  },
  {
    title: 'mult',
    value: 1,
  },
  {
    title: 'mediu',
    value: 2,
  },
  {
    title: 'rar',
    value: 3,
  },
  {
    title: 'deloc',
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
