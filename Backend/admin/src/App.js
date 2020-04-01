import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import { Layout } from 'antd';
import Login from './components/login';
import Questions, { AddQuestion, EditQuestion } from './screens/questions';
import { withAuthentication } from './hoc';
import HeaderContent from './components/header-content';
import Page from './components/page';

import 'antd/dist/antd.css';
import './App.css';

const { Header, Footer, Content } = Layout;

function App() {
  return (
    <Router>
      <Layout>
        <Header>
          <HeaderContent />
        </Header>
        <Content>
          <Page>
            <Route exact path="/" component={() => <div>HOME PAGE</div>} />
            <Route exact path="/login" component={Login} />
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
