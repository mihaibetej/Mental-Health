import React from 'react'
import {Button, Form, Input} from 'antd';
import {useHistory} from "react-router"
import {login, loginOauth,} from '../../db/auth';
import {firebaseAuth} from '../../db';

const layout = {
  labelCol: { span: 8 },
  wrapperCol: { span: 16 },
};
const tailLayout = {
  wrapperCol: { offset: 8, span: 16 },
};

const Login = () => {

  const history = useHistory();

  const handleClickOauth = (ev) => {
    loginOauth(ev.target.id)
  };

  const onFinish = ({ email, password }) => {
    console.log('Success:');
    login(email, password);
    firebaseAuth().onAuthStateChanged((user) => {
      //save user to state maybe display in a header ?
      console.log('loggedin', user)
      history.push('/questions')
    })
  };

  const onFinishFailed = errorInfo => {
    console.log('Failed:', errorInfo);
  };

  return (
    <Form
      {...layout}
      name="basic"
      initialValues={{ remember: true }}
      onFinish={onFinish}
      onFinishFailed={onFinishFailed}
    >
      <Form.Item
        label="Email"
        name="email"
        rules={[{ required: true, message: 'Please input your email!' }]}
      >
        <Input/>
      </Form.Item>

      <Form.Item
        label="Password"
        name="password"
        rules={[{ required: true, message: 'Please input your password!' }]}
      >
        <Input.Password/>
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