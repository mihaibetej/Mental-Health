import React from 'react';
import { Button, Form, Input } from 'antd';
import { useHistory } from 'react-router';
import { forgotPassword } from '../../db/auth';

import './forgot-password.css';

const layout = {
  labelCol: { span: 8 },
  wrapperCol: { span: 16 },
};
const tailLayout = {
  wrapperCol: { offset: 8, span: 16 },
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
      <Form
        {...layout}
        className="forgot-password-form"
        name="basic"
        onFinish={onFinish}
      >
        <Form.Item
          label="Email"
          name="email"
          rules={[{ required: true, message: 'Please input your email!' }]}
        >
          <Input />
        </Form.Item>

        <Form.Item {...tailLayout}>
          <Button type="primary" htmlType="submit">
            Send Email
          </Button>
        </Form.Item>
      </Form>
    </div>
  );
};

export default ForgotPassword;
