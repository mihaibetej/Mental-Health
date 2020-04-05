import './messages.css';
import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import {
  List,
  Typography,
  Button,
  Popconfirm,
  Row,
  Col,
  notification,
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
    <div className="messages-wrapper">
      <div className="messages">
        <List
          header={
            <div className="messages__header">
              <Typography.Title level={3}>Mesaje</Typography.Title>
              <Button
                type="primary"
                shape="round"
                onClick={handleCreateMessage}
              >
                Adauga un mesaj
              </Button>
            </div>
          }
          itemLayout="vertical"
          dataSource={messages}
          renderItem={({ body, from, to, creationDate, id }) => (
            <List.Item
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
              <List.Item.Meta
                description={
                  <>
                    <Row>
                      <Col span={1}>Creat:</Col>
                      <Col span={23}>
                        {creationDate ? formatDateTime(creationDate) : ''}
                      </Col>
                    </Row>
                    <Row>
                      <Col span={1}>From:</Col>
                      <Col span={23}>{from}</Col>
                    </Row>
                    <Row>
                      <Col span={1}>To:</Col>
                      <Col span={23}>{to}</Col>
                    </Row>
                  </>
                }
              />
              <Row>{body}</Row>
            </List.Item>
          )}
        />
      </div>
    </div>
  );
};

export default withAuthorization(Messages);
