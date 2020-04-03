import React from 'react';
import { Menu } from 'antd';
import { useLocation, Link } from 'react-router-dom';

const Navigation = () => {
  const location = useLocation();
  const current = location.pathname && location.pathname.split('/')[1];
  console.log('Navigation -> current', current);

  return (
    <Menu theme="dark" selectedKeys={[current]} mode="horizontal">
      <Menu.Item key="questions">
        <Link to="/questions">Intrebari</Link>
      </Menu.Item>
      <Menu.Item key="news">
        <Link to="/news">Stiri</Link>
      </Menu.Item>
      <Menu.Item key="messages">
        <Link to="/messages">Mesaje</Link>
      </Menu.Item>
      <Menu.Item key="advices">
        <Link to="/advices">Sfaturi</Link>
      </Menu.Item>
      <Menu.Item key="journals">
        <Link to="/journals">Jurnale</Link>
      </Menu.Item>
      <Menu.Item key="answers">
        <Link to="/answers">Raspunsuri</Link>
      </Menu.Item>
    </Menu>
  );
};

export default Navigation;
