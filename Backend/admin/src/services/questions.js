import {db} from "../db"

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

export const getQuestions = async () => {
  const snapshot = await db.collection('questions').get()
  return snapshot.docs.map(doc => {
    console.log('Question ID', doc.id)
    return doc.data()
  });
}

export const createQuestion = async (body, answers = defaultAnswers) => {
  await db.collection('questions').add({
    body,
    answers,
  });
}

