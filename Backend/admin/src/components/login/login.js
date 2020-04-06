import React from 'react';
import { Button, Card, Form, Input } from 'antd';
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
      <Card title="Login">
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
            rules={[{ required: true, message: 'Introdu adresa de email!' }]}
          >
            <Input />
          </Form.Item>

          <Form.Item
            label="Password"
            name="password"
            rules={[{ required: true, message: 'Introdu parola!' }]}
          >
            <Input.Password />
          </Form.Item>
          <Form.Item {...tailLayout} st>
            <Button type="primary" shape="round" htmlType="submit">
              Login
            </Button>
            <Button
              className="login-form-forgot"
              shape="round"
              onClick={handleForgot}
            >
              Am uitat parola
            </Button>
          </Form.Item>
        </Form>
      </Card>
    </div>
  );
};

export default Login;
