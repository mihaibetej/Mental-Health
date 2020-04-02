import React from 'react';
import { Form } from 'antd';
import NewsItemForm from './news-item-form';
import { withAuthorization } from '../../hoc';
import { addNewsItem } from '../../services/news';

const AddNewsItem = () => {
  const [form] = Form.useForm();

  const onFinish = async ({ title, body, image }) => {
    const newsItem = {
      title,
      body,
      file: image.file
    };

    await addNewsItem(newsItem);
    form.resetFields();
  };

  return <NewsItemForm form={form} onFinish={onFinish} />;
};

export default withAuthorization(AddNewsItem);
