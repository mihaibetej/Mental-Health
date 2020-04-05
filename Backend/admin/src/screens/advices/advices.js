import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { List, notification, Popconfirm, Button, Card } from 'antd';
import { find, get } from 'lodash';

import { withAuthorization } from '../../hoc';
import { deleteAdvice, getAdvices } from '../../services/advices';
import { formatDate } from '../../utils/helpers';

import '../styles.css';

const Advices = () => {
  const history = useHistory();
  const [advices, setAdvices] = useState([]);

  useEffect(() => {
    const runEffect = async () => {
      setAdvices(await getAdvices());
    };
    runEffect();
  }, []);

  const deleteNotification = (id) => {
    const advice = get(find(advices, { id }), 'body');
    notification.open({
      message: 'Am sters cu succes sfatul:',
      description: advice,
    });
  };

  const confirmDelete = (adviceId) => () => {
    deleteAdvice(adviceId).then(async () => {
      setAdvices(await getAdvices());
      deleteNotification(adviceId);
    });
  };

  const handleEdit = (adviceId) => () => {
    history.push(`advices/${adviceId}/edit`);
  };

  const handleCreate = () => {
    history.push('advices/create');
  };

  return (
    <Card
      title="Sfaturi"
      extra={
        <Button type="primary" shape="round" onClick={handleCreate}>
          Adauga un sfat
        </Button>
      }
    >
      <List
        itemLayout="vertical"
        dataSource={advices}
        renderItem={({ body, creationDate, publishDate, id }) => (
          <List.Item
            className="general-wrapper"
            actions={[
              // eslint-disable-next-line jsx-a11y/anchor-is-valid
              <a key="list-loadmore-edit" onClick={handleEdit(id)}>
                Editeaza
              </a>,
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
            <List.Item.Meta
              description={`Created: ${formatDate(creationDate)}`}
              title={`Publish by: ${formatDate(publishDate)}`}
            />
            {body}
          </List.Item>
        )}
      />
    </Card>
  );
};

export default withAuthorization(Advices);
