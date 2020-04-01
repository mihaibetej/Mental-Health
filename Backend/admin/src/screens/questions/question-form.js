import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input } from 'antd';

import './question-form.css';

const QuestionForm = ({ form, initialValues, onFinish, submitTitle }) => {
  return (
    <div className="question-form">
      <Form
        initialValues={initialValues}
        name="add-question"
        form={form}
        onFinish={onFinish}
      >
        <Form.Item name="body" label="Question Title">
          <Input />
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

QuestionForm.propTypes = {
  submitTitle: PropTypes.string,
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
};

QuestionForm.defaultProps = {
  submitTitle: 'Save',
  initialValues: null,
};

export default QuestionForm;
