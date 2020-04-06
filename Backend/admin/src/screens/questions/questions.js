import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { find, get } from 'lodash';

// eslint-disable-next-line
import { List, notification, Popconfirm, Typography, Button, Card } from 'antd';

import { withAuthorization } from '../../hoc';
import { deleteQuestion, getQuestions } from '../../services/questions';

import '../styles.css';

const Questions = () => {
  const history = useHistory();
  const [questions, setQuestions] = useState([]);

  const deleteNotification = (id) => {
    const question = get(find(questions, { id }), 'body');
    notification.open({
      message: 'Am sters cu succes intrebarea:',
      description: question,
    });
  };

  const handleEdit = (questionId) => () => {
    history.push(`questions/${questionId}/edit`);
  };

  const handleCreate = () => {
    history.push('questions/create');
  };

  useEffect(() => {
    const runEffect = async () => {
      setQuestions(await getQuestions());
    };
    runEffect();
  }, []);

  const confirm = (questionId) => () => {
    deleteQuestion(questionId).then(async () => {
      setQuestions(await getQuestions());
      deleteNotification(questionId);
    });
  };

  return (
    <Card
      title="Intrebari chestionar"
      extra={
        <Button type="primary" shape="round" onClick={handleCreate}>
          Adauga o intrebare
        </Button>
      }
    >
      <List
        itemLayout="horizontal"
        dataSource={questions}
        renderItem={({ body, id }, idx) => (
          <List.Item
            className="general-wrapper"
            actions={[
              // eslint-disable-next-line jsx-a11y/anchor-is-valid
              <a key="list-loadmore-edit" onClick={handleEdit(id)}>
                Editeaza
              </a>,
              <Popconfirm
                title="Esti sigur ca vrei sa stergi aceasta intrebare?"
                onConfirm={confirm(id)}
                okText="Da"
                cancelText="Nu"
              >
                {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
                <a href="#">Sterge</a>
              </Popconfirm>,
            ]}
          >
            <div>
              <Typography.Text>{idx + 1}</Typography.Text>
              {`. ${body}`}
            </div>
          </List.Item>
        )}
      />
    </Card>
  );
};

export default withAuthorization(Questions);
