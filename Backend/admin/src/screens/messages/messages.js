import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import {
  List,
  Button,
  Popconfirm,
  Row,
  Col,
  notification,
  Card,
  Typography,
} from 'antd';
import { find, get } from 'lodash';
import { withAuthorization } from '../../hoc';
import { getMessages, deleteMessage } from '../../services/messages';

import { formatDateTime } from '../../utils/helpers';

const Messages = () => {
  const history = useHistory();
  const [messages, setMessages] = useState([]);

  useEffect(() => {
    const runEffect = async () => {
      setMessages(await getMessages());
    };
    runEffect();
  }, []);

  const deleteNotification = (id) => {
    const message = get(find(messages, { id }), 'body');
    notification.open({
      message: 'Am sters cu succes mesajul:',
      description: message,
    });
  };

  const confirmDelete = (messageId) => () => {
    deleteMessage(messageId).then(async () => {
      setMessages(await getMessages());
      deleteNotification(messageId);
    });
  };

  const handleEdit = (messageId) => () => {
    history.push(`messages/${messageId}/edit`);
  };

  const handleCreateMessage = () => {
    history.push('messages/create');
  };

  return (
    <Card
      title="Mesaje"
      extra={
        <Button type="primary" shape="round" onClick={handleCreateMessage}>
          Adauga un mesaj
        </Button>
      }
    >
      <List
        itemLayout="vertical"
        dataSource={messages}
        renderItem={({ body, from, to, creationDate, id }) => (
          <List.Item
            className="general-wrapper"
            actions={[
              // eslint-disable-next-line jsx-a11y/anchor-is-valid
              <a key="list-loadmore-edit" onClick={handleEdit(id)}>
                Editeaza
              </a>,
              <Popconfirm
                title="Esti sigur ca vrei sa stergi acest mesaj?"
                onConfirm={confirmDelete(id)}
                okText="Da"
                cancelText="Nu"
              >
                {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
                <a href="#">Sterge</a>
              </Popconfirm>,
            ]}
          >
            <div>
              <List.Item.Meta
                description={
                  <div>
                    <Row justifyContent="space-between">
                      <Typography.Paragraph strong>
                        Creat:&nbsp;&nbsp;
                      </Typography.Paragraph>
                      <Typography.Paragraph>
                        {creationDate ? formatDateTime(creationDate) : ''}
                      </Typography.Paragraph>
                    </Row>
                    <Row>
                      <Typography.Paragraph strong>
                        De la:&nbsp;&nbsp;
                      </Typography.Paragraph>
                      <Typography.Paragraph>{from}</Typography.Paragraph>
                    </Row>
                    <Row>
                      <Typography.Paragraph strong>
                        Catre:&nbsp;&nbsp;
                      </Typography.Paragraph>
                      <Typography.Paragraph>{to}</Typography.Paragraph>
                    </Row>
                  </div>
                }
              />
              {body}
            </div>
          </List.Item>
        )}
      />
    </Card>
  );
};

export default withAuthorization(Messages);
