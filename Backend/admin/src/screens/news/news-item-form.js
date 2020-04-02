import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input, Upload } from 'antd';
import './news-item-form.css';

const NewsItemForm = ({ form, initialValues, onFinish }) => {
  const values = initialValues
    ? {
      body: initialValues.body,
      title: initialValues.title,
      image: initialValues.image
    }
    : {};

  return (
    <div className="news-item-form">
      <Form
        initialValues={values}
        name="add-news-item"
        form={form}
        onFinish={onFinish}
      >
        <Form.Item name="title" label="Title">
          <Input />
        </Form.Item>
        <Form.Item name="body" label="Description">
          <Input.TextArea />
        </Form.Item>
        <Form.Item name="image" label="Image">
          <Upload
            listType="picture-card"
            beforeUpload={() => false}
          >
            <Button>
              Incarca imagine
            </Button>
          </Upload>
        </Form.Item>
        <Form.Item>
          <Button type="primary" htmlType="submit">
            Trimite
          </Button>
        </Form.Item>
      </Form>
    </div>
  );
};

NewsItemForm.propTypes = {
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
  onFinish: PropTypes.func.isRequired,
};

NewsItemForm.defaultProps = {
  initialValues: null,
};

export default NewsItemForm;
