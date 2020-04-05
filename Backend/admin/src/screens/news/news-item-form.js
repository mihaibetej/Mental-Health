import React from 'react';
import PropTypes from 'prop-types';
import { Button, Form, Input ,Row, Card } from 'antd';
import { useHistory } from 'react-router';

import './news-item-form.css';
import UploadImage from '../../components/upload/upload'

const NewsItemForm = ({ form, initialValues, onFinish, title }) => {
  const values = initialValues
    ? {
        body: initialValues.body,
        title: initialValues.title,
      }
    : {};

    const image = initialValues && initialValues.image ? initialValues.image : ""; 

    const formItemLayout = {
      labelCol: { span: 6 },
      wrapperCol: { span: 14 },
    };

    const history = useHistory();

    const onCancel = () => {
      history.goBack();
    };

  return (
    <div className="news-item-form">
      <Card
        title={title}
      >
        <Form
          {...formItemLayout}
          initialValues={values}
          name="add-news-item"
          form={form}
          onFinish={onFinish}
        >
          <Form.Item
            name="title"
            label="Titlu"
            rules={[
              {
                required: true,
                message: 'Titlul stirii nu poate fi gol',
              },
            ]}
          >
            <Input />
          </Form.Item>
          <Form.Item
            name="body"
            label="Descriere"
            rules={[
              {
                required: true,
                message: 'Descrierea stirii nu poate fi goala',
              },
            ]}
          >
            <Input.TextArea />
          </Form.Item>
          <UploadImage defaultImage={image} />
          <Row justify="space-between">
            <Form.Item>
              <Button shape="round" onClick={onCancel}>
                Anuleaza
              </Button>
            </Form.Item>
            <Form.Item>
              <Button type="primary" shape="round" htmlType="submit">
                Salveaza
              </Button>
            </Form.Item>
          </Row>
        </Form>
      </Card>
    </div>
  );
};

NewsItemForm.propTypes = {
  initialValues: PropTypes.object,
  form: PropTypes.object.isRequired,
  onFinish: PropTypes.func.isRequired,
  title: PropTypes.string.isRequired,
};

NewsItemForm.defaultProps = {
  initialValues: null,
};

export default NewsItemForm;
