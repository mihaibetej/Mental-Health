import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input, DatePicker, Row, Card } from 'antd';
import moment from 'moment';
import { useHistory } from 'react-router';

import '../styles.css';

const AdviceForm = ({ form, initialValues, onFinish, submitTitle }) => {
  const history = useHistory();
  const values = initialValues
    ? {
        body: initialValues.body,
        creationDate: moment(initialValues.creationDate.toDate()),
        publishDate: moment(initialValues.publishDate.toDate()),
      }
    : {};

  const onCancel = () => {
    history.goBack();
  };

  const formItemLayout = {
    labelCol: { span: 6 },
    wrapperCol: { span: 18 },
  };

  return (
    <div className="form-wrapper">
      <Card title="Adauga un sfat">
        <Form
          {...formItemLayout}
          initialValues={values}
          name="add-question"
          form={form}
          onFinish={onFinish}
        >
          <Form.Item
            name="body"
            label="Advice"
            rules={[
              {
                required: true,
                message: 'Continutul sfatului nu poate fi gol',
              },
            ]}
          >
            <Input.TextArea />
          </Form.Item>
          <Form.Item
            name="publishDate"
            label="Date for publish"
            rules={[
              {
                required: true,
                message: 'Data publicarii sfatului nu poate fi goala',
              },
            ]}
          >
            <DatePicker />
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

AdviceForm.propTypes = {
  submitTitle: PropTypes.string,
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
  onFinish: PropTypes.func.isRequired,
};

AdviceForm.defaultProps = {
  submitTitle: 'Salveaza',
  initialValues: null,
};

export default AdviceForm;
