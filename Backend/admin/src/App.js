import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import { Layout } from 'antd';

import { BrowserRouter as Router } from 'react-router-dom';
import { Layout, Skeleton, Row } from 'antd';

import { withAuthentication } from './hoc';
import HeaderContent from './components/header-content';
import Navigation from './components/navigation';
import Page from './components/page';
import AppRoutes from './components/app-routes';

import 'antd/dist/antd.css';
import './App.css';

const { Header, Footer, Content } = Layout;

function App({ authUser, authLoading }) {
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
            {authLoading ? (
              <Row>
                <Skeleton active />
              </Row>
            ) : (
              <AppRoutes authUser={authUser} />
            )}
          </Page>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </Router>
  );
}

export default withAuthentication(App);
