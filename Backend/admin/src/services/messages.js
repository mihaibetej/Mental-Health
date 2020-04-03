import { db } from '../db';

export const getMessages = async () => {
  const snapshot = await db.collection('messages').get();
  return snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));
};

export const getMessageById = async (id) => {
  const message = await db
    .collection('messages')
    .doc(id)
    .get()
    // eslint-disable-next-line consistent-return
    .then((doc) => {
      if (doc.exists) {
        return doc.data();
      }
    })
    .catch((e) => {
      console.log(`Error getting data for message with id ${id}`, e);
    });

  return message;
};

export const createMessage = async (body, from, to) => {
  await db.collection('messages').add({
    body,
    from,
    to,
    creationDate: new Date(),
  });
};

export const updateMessage = async (id, body, from, to) => {
  await db.collection('messages').doc(id).update({
    body,
    from,
    to,
  });
};

export const deleteMessage = async (id) => {
  await db.collection('messages').doc(id).delete();
};
