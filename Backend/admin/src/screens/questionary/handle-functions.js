import { keys, find } from 'lodash';
import { setAnswers } from '../../services/answers';

export const handleSubmitAnswers = async ({
  formValues,
  questions,
  userID,
}) => {
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
