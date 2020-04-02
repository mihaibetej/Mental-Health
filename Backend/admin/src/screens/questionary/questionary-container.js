import React from 'react';
import Questionary from './questionary';
import { AuthContext } from '../../contexts';

const QuestionaryContainer = (props) => {
  return (
    <AuthContext.Consumer>
      {(authUser) => <Questionary authUser={authUser} {...props} />}
    </AuthContext.Consumer>
  );
};

export default QuestionaryContainer;
