import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input, DatePicker, Row, Card } from 'antd';
import moment from 'moment';
import '../styles.css';

const AdviceForm = ({
  form,
  initialValues,
  onFinish,
  submitTitle,
  onCancel,
}) => {
  const values = initialValues
    ? {
        body: initialValues.body,
        creationDate: moment(initialValues.creationDate.toDate()),
        publishDate: moment(initialValues.publishDate.toDate()),
      }
    : {};

  return (
    <div className="form-wrapper">
      <Card title="Adauga un sfat">
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
          <Row className="action-btn-group">
            <Button shape="round" className="action-btn" onClick={onCancel}>
              Cancel
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
  submitTitle: 'Save',
  initialValues: null,
};

export default AdviceForm;
