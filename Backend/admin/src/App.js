import React from 'react';
import {BrowserRouter as Router, Route} from "react-router-dom";
import {Layout} from 'antd';
import Login from './components/login';
import Questions, {AddQuestion} from "./screens/questions"
import {withAuthentication} from "./hoc";
import HeaderContent from './components/header-content';
import 'antd/dist/antd.css';
import './App.css';

const { Header, Footer, Content } = Layout;

function App() {
  return (
    <Router>
      <Layout>
        <Header><HeaderContent/></Header>
        <Content>
          <Route exact path="/" component={() => <div>HOME PAGE</div>}/>
          <Route exact path="/login" component={Login}/>
          <Route exact path="/questions" component={Questions}/>
          <Route exact path="/questions/create" component={AddQuestion}/>
          <Route exact path="/questions/:id(\\d+)/edit" component={() => <div>Edit Question by ID</div>}/>
          <Route exact path="/questions/:id(\\d+)" component={() => <div>Question By ID</div>}/>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </Router>
  );
}

export default withAuthentication(App);
