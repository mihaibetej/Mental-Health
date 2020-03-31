import React, {useEffect, useState} from 'react';
import {getQuestions} from "../../services/questions";

const Questions = () => {

  const [questions, setQuestions] = useState([]);

  useEffect(() => {
    const runEffect = async () => {
      setQuestions(await getQuestions());
    };
    runEffect();
  }, [setQuestions]);


  console.log('questions', questions)
  return (
    <div>
      Questions Page
    </div>
  )
}

export default Questions;