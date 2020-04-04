import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useHistory } from 'react-router';
import { BarChart, Bar } from 'recharts';
import { List, Typography, Row, Skeleton, Card } from 'antd';
import { take, noop, isEmpty } from 'lodash';
import { withAuthorization } from '../../hoc';
import { usersSubscribe, answersSubscribe } from '../../services/answers';
import { getDateKey } from '../../utils/helpers';
import theme from '../../utils/theme';
// import { calculateRating } from './answers-common';
import './answers.css';

const calculateRating = (items) =>
  items.reduce((acc, next) => acc + next.answer_value, 0);

const prepData = (answers) =>
  take(
    answers.map(({ created, items }) => ({
      name: getDateKey(created.toDate()),
      value: calculateRating(items),
    })),
    5
  );

const SmallChart = ({ userId }) => {
  const [answers, setAnswers] = useState([]);

  useEffect(() => {
    const unsubscribe = answersSubscribe(userId, setAnswers);

    return unsubscribe;
  }, [userId]);

  console.log('answers', answers);
  //console.log(prepData(answers))

  return (
    prepData(answers).length > 1 && (
      <BarChart width={150} height={50} data={prepData(answers)}>
        <Bar type="monotone" dataKey="value" fill={theme.colors.primary} />
      </BarChart>
    )
  );
};

SmallChart.propTypes = {
  userId: PropTypes.string.isRequired,
};

const DetailsButton = ({ onPress }) => (
  // eslint-disable-next-line
  <a onClick={onPress}>Detalii</a>
);

DetailsButton.propTypes = {
  onPress: PropTypes.func,
};

DetailsButton.defaultProps = {
  onPress: noop,
};

const Answers = () => {
  const history = useHistory();
  const [userList, setUserList] = useState([]);

  useEffect(() => {
    const unsubscribe = usersSubscribe(setUserList);
    return unsubscribe;
  }, []);

  const handleDetails = (userId) => () => {
    history.push(`answers/${userId}`);
  };

  return (
    <div>
      {isEmpty(userList) ? (
        <Row>
          <Skeleton active />
        </Row>
      ) : (
        <Card title="Raspunsuri Utilizatori">
          <List
            itemLayout="horizontal"
            dataSource={userList}
            renderItem={({ email, id }, idx) => {
              return (
                <List.Item
                  actions={[
                    <DetailsButton
                      key="details-button"
                      onPress={handleDetails(id)}
                    />,
                  ]}
                >
                  <div className="answers-item-wrapper">
                    <span>
                      <Typography.Text>{idx + 1}</Typography.Text>
                      {`. ${email}`}
                    </span>
                    <SmallChart userId={id} />
                  </div>
                </List.Item>
              );
            }}
          />
        </Card>
      )}
    </div>
  );
};

export default withAuthorization(Answers);
