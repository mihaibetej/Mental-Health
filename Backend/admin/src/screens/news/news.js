import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import {
  Typography,
  Button,
  Card,
  notification,
  List,
  Popconfirm,
  Avatar,
  Skeleton,
} from 'antd';
import { find, get, isEmpty } from 'lodash';

import { withAuthorization } from '../../hoc';
import { getNews, removeNewsItem } from '../../services/news';
import { formatDate, generateDataOnLoading } from '../../utils/helpers';
import defaultImage from '../../assets/default.jpg';
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

  const deleteNotification = (id) => {
    const newsItem = get(find(news, { id }), 'body');
    notification.open({
      message: 'Am sters cu succes stirea:',
      description: newsItem,
    });
  };

  const confirmDelete = (newsItemId) => () => {
    removeNewsItem(newsItemId).then(async () => {
      setNews(await getNews());
      deleteNotification(newsItemId);
    });
  };

  const handleEdit = (newsItemId) => () => {
    history.push(`news/${newsItemId}/edit`);
  };

  const handleCreate = () => {
    history.push('news/create');
  };

  const dataOnLoading = generateDataOnLoading(3);

  return (
    <Card
      title="Stiri"
      extra={
        <Button type="primary" shape="round" onClick={handleCreate}>
          Adauga o stire
        </Button>
      }
    >
      {isEmpty(news) ? (
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
          dataSource={dataOnLoading}
          renderItem={({ title }) => (
            <List.Item>
              <Card
                className="margin"
                actions={[
                  <Typography.Text>Editeaza</Typography.Text>,
                  /* eslint-disable-next-line jsx-a11y/anchor-is-valid */
                  <a href="#">Sterge</a>,
                ]}
              >
                <Skeleton active>
                  <Skeleton.Meta
                    title={title}
                    description="This is the description"
                  />
                </Skeleton>
              </Card>
            </List.Item>
          )}
        />
      ) : (
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
          renderItem={({ title, body, id, image, date }) => (
            <List.Item className="content">
              <Card
                className="margin"
                cover={
                  <img
                    className="image"
                    src={image || defaultImage}
                    alt="No available"
                  />
                }
                actions={[
                  <Typography.Text onClick={handleEdit(id)}>
                    Editeaza
                  </Typography.Text>,
                  <Popconfirm
                    title="Esti sigur ca vrei sa stergi aceasta intrebare?"
                    onConfirm={confirmDelete(id)}
                    okText="Da"
                    cancelText="Nu"
                  >
                    {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
                    <a href="#">Sterge</a>
                  </Popconfirm>,
                ]}
              >
                <Card.Meta
                  title={`${title} : ${formatDate(date)}`}
                  description={body}
                />
              </Card>
            </List.Item>
          )}
        />
      )}
    </Card>
  );
};

export default withAuthorization(News);
