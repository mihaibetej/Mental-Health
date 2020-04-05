import React, { useEffect, useState } from 'react';
import { Form, notification } from 'antd';
import { useParams } from 'react-router';
import MessageForm from './message-form';
import { withAuthorization } from '../../hoc';
import { getMessageById, updateMessage } from '../../services/messages';

const EditMessage = () => {
  const [form] = Form.useForm();
  const { id } = useParams();
  const [message, setMessage] = useState(null);

  useEffect(() => {
    const runEffect = async () => {
      setMessage(await getMessageById(id));
    };
    runEffect();
  }, [id]);

  const editNotification = (messageContent) => {
    notification.open({
      message: 'Am editat cu success mesajul:',
      description: messageContent,
    });
  };

  const onFinish = async ({ body, from, to }) => {
    await updateMessage(id, body, from, to);
    editNotification(body);
  };

  if (!message) return null;

  return (
    <MessageForm initialValues={message} form={form} onFinish={onFinish} />
  );
};

export default withAuthorization(EditMessage);
