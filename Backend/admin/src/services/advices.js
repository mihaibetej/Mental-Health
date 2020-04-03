import { db } from '../db';

export const getAdvices = async () => {
  const snapshot = await db.collection('daily-advices').get();
  return snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));
};

export const getAdviceById = async (id) => {
  const advice = await db
    .collection('daily-advices')
    .doc(id)
    .get()
    // eslint-disable-next-line consistent-return
    .then((doc) => {
      if (doc.exists) {
        return doc.data();
      }
    })
    .catch((e) => {
      console.log(`Error getting data for advice with id ${id}`, e);
    });

  return advice;
};

export const createAdvice = async (body, publishDate) => {
  await db.collection('daily-advices').add({
    body,
    creationDate: new Date(),
    publishDate: publishDate.toDate(),
  });
};

export const updateAdvice = async (id, body, publishDate) => {
  await db.collection('daily-advices').doc(id).update({
    body,
    publishDate: publishDate.toDate(),
  });
};

export const deleteAdvice = async (id) => {
  await db.collection('daily-advices').doc(id).delete();
};
