import './message-form.css';
import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input } from 'antd';

const MessageForm = ({ form, initialValues, onFinish, submitTitle }) => {
  const values = initialValues
    ? {
      body: initialValues.body,
      from: initialValues.from,
      to: initialValues.to,
    }
    : {};

  const layout = {
    labelCol: { span: 4 },
    wrapperCol: { span: 20 },
  };
  const tailLayout = {
    wrapperCol: { offset: 4, span: 20},
  };

  return(
    <div className="message-form-wrapper">
      <div className="message-form">
        <Form
          initialValues={values}
          name="add-question"
          form={form}
          onFinish={onFinish}
          {...layout}
        >
          <Form.Item
            name="from"
            label="From"
            rules={[{ required: true, message: 'Introdu email expeditor' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="to"
            label="To"
            rules={[{ required: true, message: 'Introdu email destinatar' }]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="body"
            label="Message"
            rules={[{ required: true, message: 'Mesajul nu poate fi gol' }]}
          >
            <Input.TextArea />
          </Form.Item>
          <Form.Item {...tailLayout}>
            <Button type="primary" htmlType="submit">
              {submitTitle}
            </Button>
          </Form.Item>
        </Form>
      </div>
    </div>
  );
};

MessageForm.propTypes = {
  submitTitle: PropTypes.string,
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
  onFinish: PropTypes.func.isRequired,
};

MessageForm.defaultProps = {
  submitTitle: 'Save',
  initialValues: null,
};

export default MessageForm;