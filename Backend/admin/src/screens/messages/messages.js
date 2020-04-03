import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { List, Typography, Button, Popconfirm } from 'antd';
import { withAuthorization } from '../../hoc';
import { getMessages, deleteMessage } from "../../services/messages";
import {find, get} from "lodash";
import {notification} from "antd/lib/index";

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

  return(
    <div className="messages">
      <List
        header={
          // eslint-disable-next-line
          <>
            <Typography.Title>Mesaje</Typography.Title>
            <Button type="dashed" onClick={handleCreateMessage}>
              Adauga un mesaj
            </Button>
          </>
        }
        bordered
        itemLayout="vertical"
        dataSource={messages}
        renderItem={({ body, from, to, creationDate,  id }) => (
          <List.Item
            actions={[
              // eslint-disable-next-line jsx-a11y/anchor-is-valid
              <a key="list-loadmore-edit" onClick={handleEdit(id)}>
                Edit
              </a>,
              <Popconfirm
                title="Esti sigur ca vrei sa stergi acest mesaj?"
                onConfirm={confirmDelete(id)}
                okText="Da"
                cancelText="Nu"
              >
                {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
                <a href="#">Delete</a>
              </Popconfirm>,
            ]}
          >
            <p>
              From: {from}
            </p>
            <p>
              To: {to}
            </p>
            <p>
            {body}
            </p>
          </List.Item>
        )}
      />
    </div>
  );
};

export default withAuthorization(Messages);