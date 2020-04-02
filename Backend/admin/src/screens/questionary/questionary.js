import React, { useEffect, useState } from 'react';
import { Button, Form, List, Typography, Spin } from 'antd';
import { keys, find } from 'lodash';

import Slider from '../../components/slider';
import { withAuthorization } from '../../hoc';
import { getQuestions } from '../../services/questions';
import { setAnswers, getUserAnswers } from '../../services/answers';

import './questionary.css';

const submitAnswers = async ({ formValues, questions, userID }) => {
  const answers = keys(formValues).reduce((acc, questionID) => {
    const value = formValues[questionID];

    if (value) {
      const question = find(questions, { id: questionID });
      const answer = {
        answer_value: value,
        answer_title: question.answers[value].title,
        question_body: question.body,
        question_id: questionID,
      };

      return [...acc, answer];
    }

    return acc;
  }, []);

  if (userID) {
    await setAnswers(answers, userID);

    return {
      loading: false,
      ok: true,
    };
  }

  return {
    loading: false,
    ok: true,
  };
};

const Questionary = ({ authUser }) => {
  const [questions, setQuestions] = useState({
    values: [],
    initialValues: {},
    loading: true,
    error: false,
    submiting: false,
  });

  const [form] = Form.useForm();
  const userID = authUser.uid;

  useEffect(() => {
    const runEffect = async () => {
      const prevAnswers = await getUserAnswers(userID);
      const newQuestions = await getQuestions();

      if (prevAnswers.items && prevAnswers.items.length > 0) {
        const { items } = prevAnswers;
        const initialValues = items.reduce((acc, item) => {
          const answ = {
            [item.question_id]: item.answer_value,
          };

          return {
            ...acc,
            ...answ,
          };
        }, {});

        setQuestions({
          values: newQuestions,
          initialValues,
          loading: false,
        });
      } else {
        setQuestions({
          values: newQuestions,
          loading: false,
        });
      }
    };
    runEffect();
  }, [userID]);

  if (questions.loading) {
    return (
      <div className="questionary">
        <Spin spinning={questions.loading} />
      </div>
    );
  }

  const onFinish = async (formValues) => {
    setQuestions({
      ...questions,
      submiting: true,
    });

    const result = await submitAnswers({
      formValues,
      questions: questions.values,
      userID,
    });

    if (result.ok) {
      setQuestions({
        ...questions,
        submiting: false,
      });
    }
  };

  return (
    <Form
      initialValues={questions.initialValues}
      name="answer-question"
      className="questionary"
      form={form}
      onFinish={onFinish}
    >
      <div className="questionary">
        <List
          className="questionary__list"
          bordered
          header={
            // eslint-disable-next-line
            <Typography.Title>Chestionar:</Typography.Title>
          }
          itemLayout="horizontal"
          dataSource={questions.values}
          renderItem={(question, nr) => {
            const { body: questionText, answers, id } = question;
            const min = 0;
            const max = answers.length - 1;

            return (
              <div key={id}>
                <Typography.Text strong>{`${
                  nr + 1
                }. ${questionText}`}</Typography.Text>
                <Form.Item name={id}>
                  <Slider
                    {...{
                      min,
                      max,
                      options: answers.map((o) => o.title),
                      name: id,
                    }}
                  />
                </Form.Item>
              </div>
            );
          }}
        />
        <Form.Item className="questionary__actions">
          <Button
            disabled={questions.submiting}
            loading={questions.submiting}
            type="primary"
            htmlType="submit"
          >
            Submit
          </Button>
        </Form.Item>
      </div>
    </Form>
  );
};

export default withAuthorization(Questionary);
