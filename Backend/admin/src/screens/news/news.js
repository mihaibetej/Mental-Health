import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { Typography, Button, Card, Avatar, List } from 'antd';

import { withAuthorization } from '../../hoc';
import { getNews, removeNewsItem } from '../../services/news';
import './news.css';
import defaultImage from '../../assets/default.jpg';

const News = () => {
  const history = useHistory();
  const [news, setNews] = useState([]);

  useEffect(() => {
    const runEffect = async () => {
      setNews(await getNews());
    };
    runEffect();
  }, []);

  const confirmDelete = (newsItemId) => () => {
    removeNewsItem(newsItemId).then(async () => {
      setNews(await getNews());
    });
  };

  const handleEdit = (newsItemId) => () => {
    history.push(`news/${newsItemId}/edit`);
  };

  const handleCreate = () => {
    history.push('news/create');
  };

  return (
    <Card
      title="Stiri"
      extra={
        <Button type="primary" shape="round" onClick={handleCreate}>
          Adauga o stire
        </Button>
      }
    >
      <List
        grid={{
          gutter: 40,
          xs: 1,
          sm: 2,
          md: 2,
          lg: 2,
          xl: 3,
          xxl: 3,
        }}
        dataSource={news}
        renderItem={({ title, body, id, image }) => (
          <List.Item className="content">
            <Card
              className="margin"
              cover={(
                <img
                  className="image"
                  src={image || defaultImage}
                  alt="No available"
                />
              )}
              actions={[
                <Typography.Text onClick={handleEdit(id)}>
                  Editeaza
                </Typography.Text>,
                <Typography.Text onClick={confirmDelete(id)}>
                  Sterge
                </Typography.Text>,
              ]}
            >
              <Card.Meta title={title} description={body} />
            </Card>
          </List.Item>
        )}
      />
    </Card>
  );
};

export default withAuthorization(News);
