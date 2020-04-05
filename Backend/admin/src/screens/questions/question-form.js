import React from 'react';
import PropTypes from 'prop-types';
import { Button, Card, Form, Input, Row } from 'antd';

import '../styles.css';
import { useHistory } from 'react-router';

const QuestionForm = ({ form, initialValues, onFinish, submitTitle }) => {
  const history = useHistory();

  const onCancel = () => {
    history.goBack();
  };

  return (
    <div className="form-wrapper">
      <Card title="Adauga o intrebare">
        <Form
          initialValues={initialValues}
          name="add-question"
          form={form}
          onFinish={onFinish}
        >
          <Form.Item
            name="body"
            label="Question Title"
            rules={[
              {
                required: true,
                message: 'Continutul intrebarii nu poate fi gol',
              },
            ]}
          >
            <Input />
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

QuestionForm.propTypes = {
  submitTitle: PropTypes.string,
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
};

QuestionForm.defaultProps = {
  submitTitle: 'Salveaza',
  initialValues: null,
};

export default QuestionForm;
