import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect,
} from 'react-router-dom';
import { Layout } from 'antd';
import Login from './components/login';
import Questions, { AddQuestion, EditQuestion } from './screens/questions';
import News, { AddNewsItem, EditNewsItem } from './screens/news';
import Advices, { CreateAdvice, EditAdvice } from './screens/advices';
import Questionary from './screens/questionary';
import { withAuthentication } from './hoc';
import HeaderContent from './components/header-content';
import Navigation from './components/navigation';
import Page from './components/page';

import 'antd/dist/antd.css';
import './App.css';

const { Header, Footer, Content } = Layout;

function App() {
  return (
    <Router>
      <Layout>
        <Header>
          <HeaderContent>
            <Navigation />
          </HeaderContent>
        </Header>
        <Content>
          <Page>
            <Switch>
              <Route exact path="/" component={() => <div>HOME PAGE</div>} />
              <Route path="/login" component={Login} />

              <Route exact path="/questions" component={Questions} />
              <Route exact path="/questions/create" component={AddQuestion} />
              <Route
                exact
                path="/questions/:id/edit"
                component={EditQuestion}
              />

              <Route exact path="/advices" component={Advices} />
              <Route exact path="/advices/create" component={CreateAdvice} />
              <Route exact path="/advices/:id/edit" component={EditAdvice} />

              <Route exact path="/news" component={News} />
              <Route exact path="/news/create" component={AddNewsItem} />
              <Route exact path="/news/:id/edit" component={EditNewsItem} />

              <Route path="/questionary" component={Questionary} />

              <Route path="*">
                <Redirect to="/questions" />
              </Route>
            </Switch>
          </Page>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </Router>
  );
}

export default withAuthentication(App);
