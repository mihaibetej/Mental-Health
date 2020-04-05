import React from 'react';
import { useHistory } from 'react-router';
import { Form, notification } from 'antd';

import NewsItemForm from './news-item-form';
import { withAuthorization } from '../../hoc';
import { addNewsItem } from '../../services/news';

const AddNewsItem = () => {
  const [form] = Form.useForm();
  const history = useHistory();

  const createNotification = (title) => {
    notification.open({
      message: 'Am creat cu succes o stire:',
      description: title,
    });
  };

  const onFinish = async ({title,body,image}) => {
    await addNewsItem(title,body,image);
  
    form.resetFields();
    history.goBack();
    createNotification(title);
  };

  return (
    <NewsItemForm 
      form={form}
      onFinish={onFinish}
      title="Adauga o stire"
    />
);
};

export default withAuthorization(AddNewsItem);
