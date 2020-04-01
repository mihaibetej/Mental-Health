import React, { useEffect, useState } from 'react';
import { Form, notification } from 'antd';
import { useParams } from 'react-router';

import QuestionForm from './question-form';
import { withAuthorization } from '../../hoc';
import { updateQuestion, getQuestionById } from '../../services/questions';

const EditQuestion = () => {
  const [form] = Form.useForm();
  const { id } = useParams();
  const [question, setQuestion] = useState(null);

  useEffect(() => {
    const runEffect = async () => {
      setQuestion(await getQuestionById(id));
    };
    runEffect();
  }, []);

  const editNotification = (body) => {
    notification.open({
      message: 'Am editat cu succes intrebarea:',
      description: body,
    });
  };

  const onFinish = async ({ body }) => {
    await updateQuestion(id, body);
    editNotification(body);
  };

  if (!question) return null;
  return (
    <QuestionForm initialValues={question} form={form} onFinish={onFinish} />
  );
};

export default withAuthorization(EditQuestion);
