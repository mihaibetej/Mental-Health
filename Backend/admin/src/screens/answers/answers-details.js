import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useParams } from 'react-router';
import { List, Typography, Badge, Collapse } from 'antd';
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,
} from 'recharts';
import { take } from 'lodash';
import { withAuthorization } from '../../hoc';
import { answersSubscribe, userSubscribe } from '../../services/answers';
import { getQuestions } from '../../services/questions';

import { getDateKey } from '../../utils/helpers';
import './answers.css';
// import { calculateRating } from './answers-common';
const calculateRating = (items) =>
  items.reduce((acc, next) => acc + next.answer_value, 0)

const getDailyStatus = (rating) => {
  if (rating < 11) {
    return 'error'
  }

  if (rating < 22) {
    return 'warning'
  }

  return 'success'
}

const getQuestionStatus = (value) => {
  if (value < 1) {
    return 'error'
  }

  if (value < 3) {
    return 'warning'
  }

  return 'success'
}

const QuestionsSet = ({ items }) => {
  /* eslint-disable */
  return (
    <List
      itemLayout="horizontal"
      dataSource={items}
      renderItem={({question_body, answer_title, answer_value}, idx) => {
        return (
          <List.Item key={idx}>
            <div>
              <Badge status={getQuestionStatus(answer_value)} />
              <span>{question_body}</span>
            </div>
            <div>{answer_title}</div>
          </List.Item>
        )
      }}
    />
  )
  /* eslint-enable */
};

QuestionsSet.propTypes = {
  items: PropTypes.array.isRequired
};

const DailyListItem = ({ created, items }) => (
  <>
    <Badge status={getDailyStatus(calculateRating(items))} />
    {` ${getDateKey(created.toDate())}`}
  </>
);

DailyListItem.propTypes = {
  created: PropTypes.object.isRequired,
  items: PropTypes.array.isRequired
};

const itemsToKeys = (items) =>
  items.reduce((acc, next) => {
    return ({ ...acc, [next.question_id]: next.answer_value})
  }, {});

const prepData = (answers) => {
  return answers.map(({ created, items }) => ({
    name: getDateKey(created.toDate()),
    ...itemsToKeys(items)
  }))
};

const getLineColor = (idx) => {
  const colors = {
    0: '#02082d',
    1: '#52839b',
    2: '#0f9e66',
    3: '#3ed718',
    4: '#55c72a',
    5: '#966258',
    6: '#c389be',
    7: '#e25c54',
    8: '#a2b8f3',
    9: '#d2731a',
    10: '#8b835b',
    11: '#f5d141',
  }

  return colors[idx]
};

const getQuestionBody = (id, questions) =>
  questions
    .filter((x) => x.id === id)
    .reduce((a, n) => `${a}${n.body}`, '')

const renderTooltip = (questions) => (config) => {

  return (
    <ul className="tooltip">
      {config.payload && config.payload.map((item, i) => {
        return (
          <li style={{ borderColor: item.stroke }} className="tooltip-item">
            <Badge status={getQuestionStatus(item.value)} />
            {` (${item.value}) `}
            {getQuestionBody(item.dataKey, questions)}
          </li>
        )
      })}
    </ul>
  )
};

const EvolutionChart = ({ answers, questions }) => {
  const data = take(prepData(answers), 10)
  const questionsKeys = questions.map((x) => x.id)

  return (
    <LineChart
      width={1200}
      height={300}
      data={data}
      margin={{
        top: 5, right: 30, left: 20, bottom: 5,
      }}
    >
      <CartesianGrid strokeDasharray="3 3" />
      <XAxis dataKey="name" />
      <YAxis />
      <Tooltip content={renderTooltip(questions)}/>

      { questionsKeys.map((k, i) => (
        <Line key={k} type="monotone" dataKey={k} stroke={getLineColor(i)} />
      ))}
    </LineChart>
  )
};

EvolutionChart.propTypes = {
  answers: PropTypes.array.isRequired,
  questions: PropTypes.array.isRequired
}


const AnswersDetails = () => {
  const { userId } = useParams();
  const [answers, setAnswers] = useState([])
  const [user, setUser] = useState({})
  const [questions, setQuestions] = useState([])

  useEffect(() => {
    const unsubscribe = answersSubscribe(userId, setAnswers)

    return unsubscribe
  }, [userId])

  useEffect(() => {
    const unsubscribe = userSubscribe(userId, setUser)

    return unsubscribe
  }, [])

  useEffect(() => {
    const runEffect = async () => {
      setQuestions(await getQuestions());
    };
    runEffect();
  }, [])

  return (
    <div>
      <Typography.Title>
        Utilizator
        {user.email && ` - ${user.email}`}
      </Typography.Title>
      <EvolutionChart answers={answers} questions={questions}/>
      <Collapse accordion>
        { answers.map(
          ({ created, items }, idx) => (
            // eslint-disable-next-line
            <Collapse.Panel key={idx}
              header={<DailyListItem items={items} created={created} />}
            >
              <QuestionsSet items={items}/>
            </Collapse.Panel>
          )
        )}
      </Collapse>
    </div>
  )
}

export default withAuthorization(AnswersDetails);
