import React, { useEffect, useState } from 'react';
import { Form } from 'antd';
import { useParams } from 'react-router';

import NewsItemForm from './news-item-form';
import { withAuthorization } from '../../hoc';
import { updateNewsItem, getNewsItemById } from '../../services/news';

const EditNewsItem = () => {
  const [form] = Form.useForm();
  const { id } = useParams();
  const [newsItem, setNewsItem] = useState(null);

  useEffect(() => {
    const runEffect = async () => {
      setNewsItem(await getNewsItemById(id));
    };
    runEffect();
  }, []);

  const onFinish = async ({ title, body, image }) => {
    const item = {
      id,
      title,
      body,
      file: image.file
    };

    await updateNewsItem(item);
  };

  if (!newsItem) return null;
  return <NewsItemForm initialValues={newsItem} form={form} onFinish={onFinish} />;
};

export default withAuthorization(EditNewsItem);
