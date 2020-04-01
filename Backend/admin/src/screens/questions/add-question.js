import React from 'react';
import { Form } from 'antd';
import QuestionForm from './question-form';
import { withAuthorization } from '../../hoc';
import { createQuestion } from '../../services/questions';

const AddQuestion = () => {
  const [form] = Form.useForm();

  const onFinish = async ({ body }) => {
    await createQuestion(body);
    form.resetFields();
  };

  return <QuestionForm form={form} onFinish={onFinish} />;
};

export default withAuthorization(AddQuestion);
