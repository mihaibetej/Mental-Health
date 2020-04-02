import React from 'react';
import { Button, Form, Input } from 'antd';
import { useHistory } from 'react-router';
import { login } from '../../db/auth';

import './login.css';

const layout = {
  labelCol: { span: 8 },
  wrapperCol: { span: 10 },
};
const tailLayout = {
  wrapperCol: { offset: 12, span: 18 },
};

const Login = () => {
  const history = useHistory();

  const onFinish = ({ email, password }) => {
    login(email, password)
      .then(() => {
        console.log('Success:');
        history.push('/questions');
      })
      .catch(() => console.log('display login fail error message'));
  };

  const onFinishFailed = (errorInfo) => {
    console.log('Failed:', errorInfo);
  };

  return (
    <Form
      {...layout}
      name="basic"
      initialValues={{ remember: true }}
      onFinish={onFinish}
      onFinishFailed={onFinishFailed}
      className="login-form"
    >
      <Form.Item
        label="Email"
        name="email"
        rules={[{ required: true, message: 'Please input your email!' }]}
      >
        <Input />
      </Form.Item>

      <Form.Item
        label="Password"
        name="password"
        rules={[{ required: true, message: 'Please input your password!' }]}
      >
        <Input.Password />
      </Form.Item>

      <Form.Item {...tailLayout}>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </Form.Item>
    </Form>
  );
};

export default Login;
