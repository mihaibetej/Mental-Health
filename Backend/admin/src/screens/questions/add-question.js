import React from 'react';
import {Button, Form, Input} from 'antd';
import {withAuthorization} from "../../hoc"
import {createQuestion} from "../../services/questions"

const AddQuestion = () => {
  const [form] = Form.useForm();

  const onFinish = async ({ body }) => {
    await createQuestion(body);
    form.resetFields();
  }

  return (
    <Form name="add-question" form={form} onFinish={onFinish}>
      <Form.Item
        name="body"
        label="Question Title">
        <Input/>
      </Form.Item>
      <Form.Item>
        <Button type="primary" htmlType="submit">
          Add question
        </Button>
      </Form.Item>
    </Form>
  );
}

export default withAuthorization(AddQuestion);