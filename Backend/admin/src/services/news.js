import uuidv4 from 'uuid';
import firebase,{ db, storageRef } from '../db';

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
  const imageRef = url && firebase.storage().refFromURL(url);

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

export const updateNewsItem = async (id, title,body, image) => {
  const newsItem={
    date: new Date(),
    title,
    body
  };

  const newsItemData = await getNewsItemById(id);
  await removeImage(newsItemData.image);
  const url = image && await uploadImage(image.file);

   if(url){
    newsItem.image=url;
  }

  await db.collection('news').doc(id).update(newsItem);
};

export const addNewsItem = async ( title, body, image ) => {
  const newsItem={
    date: new Date(),
    title,
    body
  };
  
  const url = image && await uploadImage(image.file);

  if(url){
    newsItem.image=url;
  }

  db.collection('news').add(newsItem);
};
