import React from 'react';
import { Form, notification } from 'antd';
import NewsItemForm from './news-item-form';
import { withAuthorization } from '../../hoc';
import { addNewsItem } from '../../services/news';

const AddNewsItem = () => {
  const [form] = Form.useForm();

  const createNotification = (title) => {
    notification.open({
      message: 'Am creat cu succes o stire:',
      description: title,
    });
  };

  const onFinish = async ({ title, body, image }) => {
    const newsItem = {
      title,
      body,
      file: image.file,
    };

    await addNewsItem(newsItem);
    form.resetFields();
    createNotification(title);
  };

  return <NewsItemForm form={form} onFinish={onFinish} title="Adauga o stire" />;
};

export default withAuthorization(AddNewsItem);
