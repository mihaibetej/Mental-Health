import React from 'react';
import { Form, notification } from 'antd';
import AdviceForm from './advice-form';
import { withAuthorization } from '../../hoc';
import { createAdvice } from '../../services/advices';

const AddAdvice = () => {
  const [form] = Form.useForm();

  const createNotification = (adviceContent) => {
    notification.open({
      message: 'Am creat cu succes sfatul:',
      description: adviceContent,
    });
  };

  const onFinish = async ({ body, publishDate }) => {
    await createAdvice(body, publishDate);
    form.resetFields();
    createNotification(body);
  };

  return <AdviceForm form={form} onFinish={onFinish} />;
};

export default withAuthorization(AddAdvice);
