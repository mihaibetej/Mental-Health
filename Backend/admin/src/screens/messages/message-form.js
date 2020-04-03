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

  return(
    <div className="message-form">
      <Form
        initialValues={values}
        name="add-question"
        form={form}
        onFinish={onFinish}
      >
        <Form.Item name="from" label="From">
          <Input />
        </Form.Item>
        <Form.Item name="to" label="To">
          <Input />
        </Form.Item>
        <Form.Item name="body" label="Message">
          <Input.TextArea />
        </Form.Item>
        <Form.Item>
          <Button type="primary" htmlType="submit">
            {submitTitle}
          </Button>
        </Form.Item>
      </Form>
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