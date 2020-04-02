import React, { useEffect, useState } from 'react';
import { Form, notification } from 'antd';
import { useParams } from 'react-router';

import AdviceForm from './advice-form';
import { withAuthorization } from '../../hoc';
import { updateAdvice, getAdviceById } from '../../services/advices';

const EditAdvice = () => {
  const [form] = Form.useForm();
  const { id } = useParams();
  const [advice, setAdvice] = useState(null);

  useEffect(() => {
    const runEffect = async () => {
      setAdvice(await getAdviceById(id));
    };
    runEffect();
  }, []);

  const editNotification = (adviceContent) => {
    notification.open({
      message: 'Am editat cu succes sfatul:',
      description: adviceContent,
    });
  };

  const onFinish = async ({ body, publishDate }) => {
    await updateAdvice(id, body, publishDate);
    editNotification(body);
  };

  if (!advice) return null;
  return <AdviceForm initialValues={advice} form={form} onFinish={onFinish} />;
};

export default withAuthorization(EditAdvice);