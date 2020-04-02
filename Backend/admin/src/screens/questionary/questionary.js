import React, { useEffect, useState } from 'react';
import { Button, Form, List, Typography, Spin } from 'antd';

import Slider from '../../components/slider';
import { withAuthorization } from '../../hoc';
import { getQuestions } from '../../services/questions';
import { getUserAnswers } from '../../services/answers';

import { handleSubmitAnswers } from './handle-functions';

import './questionary.css';

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

  const onFinish = async (formValues) => {
    setQuestions({
      ...questions,
      submiting: true,
    });

    const result = await handleSubmitAnswers({
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

  if (questions.loading) {
    return (
      <div className="questionary">
        <Spin spinning={questions.loading} />
      </div>
    );
  }

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
                <Typography.Text strong>
                  {`${nr + 1}. ${questionText}`}
                </Typography.Text>
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
