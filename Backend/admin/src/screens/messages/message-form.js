import React from 'react';
import { useHistory } from 'react-router';
import PropTypes from 'prop-types';
import { Button, Card, Form, Input, Row } from 'antd';

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

  const formItemLayout = {
    labelCol: { span: 3 },
    wrapperCol: { span: 21 },
  };

  return (
    <div className="form-wrapper">
      <Card title="Adauga un mesaj">
        <Form
          {...formItemLayout}
          initialValues={values}
          name="add-question"
          form={form}
          onFinish={onFinish}
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
          <Row className="action-btn-group">
            <Button shape="round" className="action-btn" onClick={onCancel}>
              Anuleaza
            </Button>
            <Form.Item>
              <Button
                type="primary"
                shape="round"
                htmlType="submit"
                className="action-btn"
              >
                {submitTitle}
              </Button>
            </Form.Item>
          </Row>
        </Form>
      </Card>
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
