import { db, storageRef, storage } from '../db';
import uuidv4 from 'uuid';
export const getNews = async () => {
  const snapshot = await db.collection('news').get();
  return snapshot.docs.map((doc) => ({
    id: doc.id,
    ...doc.data(),
  }));
};

export const removeNewsItem = async (id) => {
  const newsItemData = await getNewsItemById(id);
  const imageRef = newsItemData.image && storage.refFromURL(newsItemData.image);

  imageRef && await imageRef.delete();
  await db.collection('news').doc(id).delete();
};

export const updateNewsItem = async (newsItem) => {
  const item = {
    title: newsItem.title,
    body: newsItem.body,
    date: new Date()
  }
  await db.collection('news').doc(newsItem.id).update(item);
}

export const getNewsItemById = async (id) => {
  const newsItem = await db.collection('news').doc(id).get();
  return newsItem.data();
}

export const addNewsItem = async (item) => {

  const fileName = uuidv4();
  const imageRef = storageRef.child(fileName);
  const task = imageRef.put(item.file);

  task.on('state_changed', snapshot => {
  }, error => { console.log(error) },
    () => {
      task.snapshot.ref.getDownloadURL().then((url) => {
        db.collection('news').add({
          date: new Date(),
          title: item.title,
          body: item.body,
          image: url
        });
      });
    });
};