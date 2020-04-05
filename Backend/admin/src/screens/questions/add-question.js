import React from 'react';
import { Form, notification } from 'antd';
import QuestionForm from './question-form';
import { withAuthorization } from '../../hoc';
import { createQuestion } from '../../services/questions';

const AddQuestion = () => {
  const [form] = Form.useForm();

  const createNotification = (question) => {
    notification.open({
      message: 'Am creat cu succes intrebarea:',
      description: question,
    });
  };

  const onFinish = async ({ body }) => {
    await createQuestion(body);
    form.resetFields();
    createNotification(body);
  };

  return <QuestionForm form={form} onFinish={onFinish} />;
};

export default withAuthorization(AddQuestion);
