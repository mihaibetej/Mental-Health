import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { Typography, Button, Card, Row } from 'antd';

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
    <>
      <Row justify="space-between">
        <Typography.Title>Stiri</Typography.Title>
        <Button type="primary" shape="round" onClick={handleCreate}>
          Adauga o stire
        </Button>
      </Row>
      <div className="content">
        <Row justify="space-between">
          {news && news.map(({ title, body, id, image }) => {
            return (
              <div className="card-form">
                <Card
                  cover={(
                    <img
                      className="image"
                      src={image || defaultImage}
                      alt="No available"
                    />
                  )}
                  actions={[
                    <Typography.Text onClick={handleEdit(id)}>Edit</Typography.Text>,
                    <Typography.Text onClick={confirmDelete(id)}>Stergere</Typography.Text>,
                  ]}
                >
                  <Card.Meta
                    title={title}
                    description={body}
                  />
                </Card>
              </div>
            );
          })}
        </Row>
      </div>
    </>
  );
};

export default withAuthorization(News);
