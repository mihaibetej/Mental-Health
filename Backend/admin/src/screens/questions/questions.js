import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { find, get } from 'lodash';

// eslint-disable-next-line
import { List, notification, Popconfirm, Typography, Button } from 'antd';

import { withAuthorization } from '../../hoc';
import { deleteQuestion, getQuestions } from '../../services/questions';

import './questions.css';

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
    <div className="questions-wrapper">
      <List
        className="questions-list"
        bordered
        header={
          // eslint-disable-next-line
          <>
            <Typography.Title>Intrebari chestionar:</Typography.Title>
            <Button type="dashed" onClick={handleCreate}>
              Creaza o intrebare noua
            </Button>
          </>
        }
        itemLayout="horizontal"
        dataSource={questions}
        renderItem={({ body, id }, idx) => (
          <List.Item
            actions={[
              // eslint-disable-next-line jsx-a11y/anchor-is-valid
              <a key="list-loadmore-edit" onClick={handleEdit(id)}>
                edit
              </a>,
              <Popconfirm
                title="Esti sigur ca vrei sa stergi aceasta intrebare?"
                onConfirm={confirm(id)}
                okText="Da"
                cancelText="Nu"
              >
                {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
                <a href="#">delete</a>
              </Popconfirm>,
            ]}
          >
            <Typography.Text strong>{idx + 1}</Typography.Text>
            {`. ${body}`}
          </List.Item>
        )}
      />
    </div>
  );
};

export default withAuthorization(Questions);
