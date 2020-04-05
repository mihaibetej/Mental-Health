import React from 'react';
import { Form, notification } from 'antd';
import MessageForm from './message-form';
import { withAuthorization } from '../../hoc';
import { createMessage } from '../../services/messages';

const AddMessage = () => {
  const [form] = Form.useForm();

  const createNotification = (messageContent) => {
    notification.open({
      message: 'Am creat cu succes mesajul:',
      description: messageContent,
    });
  };

  const onFinish = async ({ body, from, to }) => {
    await createMessage(body, from, to);
    form.resetFields();
    createNotification(body);
  };

  return <MessageForm form={form} onFinish={onFinish} />;
};

export default withAuthorization(AddMessage);
