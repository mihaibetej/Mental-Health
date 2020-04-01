import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router';
import { List, Typography, Popconfirm } from 'antd';

import { withAuthorization } from '../../hoc';
import { getQuestions, deleteQuestion } from '../../services/questions';

import './questions.css';

const Questions = () => {
  const history = useHistory();
  const [questions, setQuestions] = useState([]);

  const handleEdit = (questionId) => () => {
    history.push(`questions/${questionId}/edit`);
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
    });
  };

  return (
    <div className="questions-wrapper">
      <List
        className="questions-list"
        bordered
        header={<Typography.Title>Intrebari chestionar:</Typography.Title>}
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
