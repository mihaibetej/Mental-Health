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
      <Redirect to="/questions" />
      <Layout>
        <Header>
          <HeaderContent>
            <Navigation />
          </HeaderContent>
        </Header>
        <Content>
          <Page>
            <Route exact path="/" component={() => <div>HOME PAGE</div>} />
            <Route exact path="/login" component={Login} />
            <Route exact path="/questionary" component={Questionary} />
            <Switch>
              <Route exact path="/questions" component={Questions} />
              <Route exact path="/questions/create" component={AddQuestion} />
              <Route
                exact
                path="/questions/:id/edit"
                component={EditQuestion}
              />
            </Switch>
          </Page>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </Router>
  );
}

export default withAuthentication(App);
