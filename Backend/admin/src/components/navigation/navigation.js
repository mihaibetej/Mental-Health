import React, { useState } from 'react';
import { Menu } from 'antd';
import { useHistory } from 'react-router';

const Navigation = () => {
  const history = useHistory();
  const [current, setCurrent] = useState('questions');
  const handleNavClick = (e) => {
    setCurrent(e.key);
    history.push(e.key);
  };
  return (
    <Menu
      theme="dark"
      onClick={handleNavClick}
      selectedKeys={[current]}
      mode="horizontal"
    >
      <Menu.Item key="questions">Intrebari</Menu.Item>
      <Menu.Item key="news">Stiri</Menu.Item>
      <Menu.Item key="messages">Mesaje</Menu.Item>
      <Menu.Item key="advices">Sfaturi</Menu.Item>
      <Menu.Item key="journals">Jurnale</Menu.Item>
      <Menu.Item key="answers">Raspunsuri</Menu.Item>
    </Menu>
  );
};

export default Navigation;
