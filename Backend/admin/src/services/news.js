import uuidv4 from 'uuid';
import { db, storageRef, storage } from '../db';

export const getNews = async () => {
  const snapshot = await db.collection('news').get();
  return snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));
};

export const getNewsItemById = async (id) => {
  const newsItem = await db.collection('news').doc(id).get();
  return newsItem.data();
};

export const removeImage = async (url) => {
  const imageRef = url && storage.refFromURL(url);

  if (imageRef) await imageRef.delete();
};

export const uploadImage = async (file) => {
  const fileName = uuidv4();
  const imageRef = storageRef.child(fileName);

  await imageRef.put(file);

  return imageRef.getDownloadURL();
};

export const removeNewsItem = async (id) => {
  const newsItemData = await getNewsItemById(id);

  await removeImage(newsItemData.image);
  await db.collection('news').doc(id).delete();
};

export const updateNewsItem = async ({ title, body, id, file }) => {
  const newsItemData = await getNewsItemById(id);
  await removeImage(newsItemData.image);
  const url = await uploadImage(file);

  const item = {
    title,
    body,
    date: new Date(),
    image: url,
  };

  await db.collection('news').doc(id).update(item);
};

export const addNewsItem = async ( title, body, image ) => {
  const url =image&& await uploadImage(image.file);

  const newsItem={
    date: new Date(),
    title,
    body
  }

  if(url){
    newsItem.image=url;
  }

  db.collection('news').add(newsItem);
};
