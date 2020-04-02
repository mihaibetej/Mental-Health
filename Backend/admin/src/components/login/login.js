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
        window.alert('Invalid combination of email and password!');
        console.log('display login fail error message');
      });
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
        style={{ padding: '24px' }}
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
          <a className="login-form-forgot" href="/">
            Forgot password
          </a>
        </Form.Item>
      </Form>
    </div>
  );
};

export default Login;
