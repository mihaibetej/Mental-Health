import React from 'react';
import { Form, notification } from 'antd';
import QuestionForm from './question-form';
import { withAuthorization } from '../../hoc';
import { createQuestion } from '../../services/questions';
import { useHistory } from 'react-router';

const AddQuestion = () => {
  const [form] = Form.useForm();
  const history = useHistory();

  const onCancel = () => {
    history.push('questions');
  };

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

  return <QuestionForm form={form} onFinish={onFinish} onCancel={onCancel} />;
};

export default withAuthorization(AddQuestion);
