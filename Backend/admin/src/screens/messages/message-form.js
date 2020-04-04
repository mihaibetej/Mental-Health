import './message-form.css';
import React from 'react';
import { useHistory } from 'react-router';
import PropTypes from 'prop-types';
import { Button, Form, Input } from 'antd';

const MessageForm = ({ form, initialValues, onFinish, submitTitle }) => {
  const history = useHistory();
  const values = initialValues
    ? {
      body: initialValues.body,
      from: initialValues.from,
      to: initialValues.to,
    }
    : {};

  const onCancel = () => {
    history.goBack();
  };

  return(
    <div className="message-form-wrapper">
      <div className="message-form">
        <Form
          initialValues={values}
          name="add-question"
          form={form}
          onFinish={onFinish}
          labelCol={{span: 6}}
          wrapperCol={{span: 14}}
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
            label="Mesaj"
            rules={[{ required: true, message: 'Mesajul nu poate fi gol' }]}
          >
            <Input.TextArea />
          </Form.Item>
          <Form.Item wrapperCol={{ offset: 6, span: 14}}>
            <Button type="primary" htmlType="submit">
              {submitTitle}
            </Button>
            <Button htmlType="button" onClick={onCancel} className="button--cancel">
              Anulare
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
  submitTitle: 'Salveaza',
  initialValues: null,
};

export default MessageForm;