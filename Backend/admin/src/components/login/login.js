import React from 'react';
import { Button, Form, Input } from 'antd';
import { useHistory } from 'react-router';
import { login } from '../../db/auth';

import './login.css';

const layout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 16 },
};
const tailLayout = {
  wrapperCol: { offset: 6, span: 16 },
};

const Login = () => {
  const history = useHistory();

  const [form] = Form.useForm();

  const onFinish = ({ email, password }) => {
    login(email, password)
      .then(() => {
        console.log('Success:');
        history.push('/questions');
      })
      .catch(() => {
        form.resetFields();
        console.log('display login fail error message');
      });
  };

  const handleForgot = () => {
    history.push('/forgot-password');
  };

  const onFinishFailed = (errorInfo) => {
    console.log('Failed:', errorInfo);
  };

  return (
    <div className="login-wrapper">
      <Form
        {...layout}
        name="basic"
        initialValues={{ remember: true }}
        onFinish={onFinish}
        onFinishFailed={onFinishFailed}
        className="login-form"
        form={form}
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
        <Form.Item {...tailLayout} st>
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
          <Button className="login-form-forgot" onClick={handleForgot}>
            Forgot password
          </Button>
        </Form.Item>
      </Form>
    </div>
  );
};

export default Login;
