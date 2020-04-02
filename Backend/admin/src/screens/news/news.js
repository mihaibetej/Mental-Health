import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { Typography, Button, Card, Row, Col, Avatar } from 'antd';

import { withAuthorization } from '../../hoc';
import { getNews, removeNewsItem } from '../../services/news';
import './news.css';

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

  return (<div>
    <Typography.Title>Noutati</Typography.Title>
    <Button type="dashed" onClick={handleCreate}>
      Adauga
      </Button>
    <div className="content">
      <Row justify="space-between">
        {news && news.map(({ title, body, id, image }) => {
          return (<Col span={8}><Card
            className="margin"
            cover={
              <Avatar
                shape="square"
                size={64}
                src={image}
              />
            }
            actions={[
              <Typography.Text onClick={handleEdit(id)}>Edit</Typography.Text>,
              <Typography.Text onClick={confirmDelete(id)}>Stergere</Typography.Text>,
            ]}
          >
            <Card.Meta
              title={title}
              description={body}
            />
          </Card></Col>)
        })}
      </Row>
    </div>

  </div>
  );
};

export default withAuthorization(News);
