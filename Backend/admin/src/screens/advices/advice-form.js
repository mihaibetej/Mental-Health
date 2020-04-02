import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input, DatePicker } from 'antd';
import moment from 'moment';
import './advice-form.css';

const AdviceForm = ({ form, initialValues, onFinish, submitTitle }) => {
  const values = initialValues
    ? {
        body: initialValues.body,
        creationDate: moment(initialValues.creationDate.toDate()),
        publishDate: moment(initialValues.publishDate.toDate()),
      }
    : {};

  return (
    <div className="advice-form">
      <Form
        initialValues={values}
        name="add-question"
        form={form}
        onFinish={onFinish}
      >
        <Form.Item name="body" label="Advice">
          <Input.TextArea />
        </Form.Item>
        <Form.Item name="publishDate" label="Date for publish">
          <DatePicker />
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

AdviceForm.propTypes = {
  submitTitle: PropTypes.string,
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
  onFinish: PropTypes.func.isRequired,
};

AdviceForm.defaultProps = {
  submitTitle: 'Save',
  initialValues: null,
};

export default AdviceForm;
