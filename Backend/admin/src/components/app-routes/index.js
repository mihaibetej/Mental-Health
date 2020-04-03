import React from 'react';
import { Route, Switch, Redirect } from 'react-router-dom';

import { isNil } from 'lodash';

import Login from '../login';
import Questions, { AddQuestion, EditQuestion } from '../../screens/questions';
import News, { AddNewsItem, EditNewsItem } from '../../screens/news';
import Advices, { CreateAdvice, EditAdvice } from '../../screens/advices';
import Questionary from '../../screens/questionary';
import ForgotPassword from '../forgot-password';

const AppRoutes = ({ authUser }) => {
  return !isNil(authUser) ? (
    <Switch>
      <Route exact path="/" component={() => <div>HOME PAGE</div>} />
      <Route exact path="/questions" component={Questions} />
      <Route exact path="/questions/create" component={AddQuestion} />
      <Route exact path="/questions/:id/edit" component={EditQuestion} />

      <Route exact path="/advices" component={Advices} />
      <Route exact path="/advices/create" component={CreateAdvice} />
      <Route exact path="/advices/:id/edit" component={EditAdvice} />

      <Route exact path="/news" component={News} />
      <Route exact path="/news/create" component={AddNewsItem} />
      <Route exact path="/news/:id/edit" component={EditNewsItem} />

      <Route exact path="/questionary" component={Questionary} />

      <Route path="*">
        <Redirect to="/questions" />
      </Route>
    </Switch>
  ) : (
    <Switch>
      <Route path="/login" component={Login} />
      <Route path="/forgot-password" component={ForgotPassword} />
      <Route path="*">
        <Redirect to="/login" />
      </Route>
    </Switch>
  );
};

export default AppRoutes;
