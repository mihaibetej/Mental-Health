import React from 'react';
import { Button, Card, Form, Input } from 'antd';
import { useHistory } from 'react-router';
import { forgotPassword } from '../../db/auth';

import './forgot-password.css';

const layout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 18 },
};
const tailLayout = {
  wrapperCol: { offset: 2, span: 16 },
};

const ForgotPassword = () => {
  const history = useHistory();

  const onFinish = ({ email, password }) => {
    forgotPassword(email, password)
      .then(() => {
        console.log('Success:');
        history.push('/login');
      })
      .catch(() => console.log('display login fail error message'));
  };

  return (
    <div className="forgot-password-wrapper">
      <Card title="Am uitat parola">
        <Form {...layout} name="basic" onFinish={onFinish}>
          <Form.Item
            label="Email"
            name="email"
            rules={[{ required: true, message: 'Introdu adresa de mail!' }]}
          >
            <Input />
          </Form.Item>

          <Form.Item {...tailLayout}>
            <Button type="primary" shape="round" htmlType="submit">
              Trimite Email
            </Button>
          </Form.Item>
        </Form>
      </Card>
    </div>
  );
};

export default ForgotPassword;
