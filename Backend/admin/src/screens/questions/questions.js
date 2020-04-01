import React, { useEffect, useState } from 'react';
import { Button, Form } from 'antd';
import { keys } from 'lodash';

import Slider from '../../components/slider';
import { withAuthorization } from '../../hoc';
import { getQuestions } from '../../services/questions';
import { setAnswers } from '../../services/answers';

const submitQuestions = (formValues, questions) => {
  const answers = keys(formValues).reduce((acc, questionID) => {
    const value = formValues[questionID];

    if (value) {
      const question = questions[questionID];
      const answer = {
        answer_id: value,
        answer_value: question.answers[value].title,
        question_body: question.body,
        question_id: questionID,
      };

      return [...acc, answer];
    }

    return acc;
  }, []);

  console.log('Submitting to server: !!!!!', {
    answers,
  });

  setAnswers(answers, 'H5Vrh55coIzNDCPNrNQ8');
  return answers;
};

const Questions = () => {
  const [questions, setQuestions] = useState([]);
  const [form] = Form.useForm();

  const onFinish = async (formValues) => {
    submitQuestions(formValues, questions);
  };

  useEffect(() => {
    const runEffect = async () => {
      setQuestions(await getQuestions());
    };
    runEffect();
  }, []);

  return (
    <Form name="add-question" form={form} onFinish={onFinish}>
      <div style={{ padding: 15 }}>
        <h1>Chestionar:</h1>
        {keys(questions).map((questionID) => {
          const question = questions[questionID];

          const { body, answers } = question;
          const min = 0;
          const max = answers.length - 1;

          return (
            <div key={questionID}>
              <br />
              <p>{body}</p>
              <div>
                <Form.Item name={questionID}>
                  <Slider
                    {...{
                      min,
                      max,
                      options: answers.map((o) => o.title),
                      name: questionID,
                    }}
                  />
                </Form.Item>
              </div>
            </div>
          );
        })}
      </div>

      <Form.Item>
        <Button type="primary" htmlType="submit">
          Submit
        </Button>
      </Form.Item>
    </Form>
  );
};

export default withAuthorization(Questions);
