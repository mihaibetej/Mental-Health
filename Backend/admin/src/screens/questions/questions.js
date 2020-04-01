import React, {useEffect, useState} from 'react';

import {withAuthorization} from "../../hoc";
import {getQuestions} from "../../services/questions";

const Questions = () => {

  const [questions, setQuestions] = useState([]);

  useEffect(() => {
    const runEffect = async () => {
      setQuestions(await getQuestions());
    };
    runEffect();
  }, []);


  console.log('questions', questions)
  return (
    <div>
      {questions.map(({ body }) => {
        return <div>{body}</div>
      })}
    </div>
  )
}

export default withAuthorization(Questions);