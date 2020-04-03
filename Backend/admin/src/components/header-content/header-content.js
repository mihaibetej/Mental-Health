import React from 'react';
import { isNil } from 'lodash';
import { LogoutOutlined } from '@ant-design/icons';
import { useHistory } from 'react-router';

import { AuthContext } from '../../contexts';

import './header-content.css';
import { logout } from '../../db/auth';

const HeaderContent = ({ children }) => {
  const history = useHistory();

  const handleLogout = () => {
    logout();
    history.push('/login');
  };

  return (
    <AuthContext.Consumer>
      {(authUser) => {
        // todo: add logout button
        return !isNil(authUser) ? (
          <div className="header-content">
            <div style={{ color: 'white' }}>
              Welcome &nbsp;
              {authUser && authUser.email}
            </div>
            <div className="header-content__navigation">{children}</div>
            <div className="header-logout" onClick={handleLogout}>
              <LogoutOutlined style={{ color: 'white' }} />
            </div>
          </div>
        ) : null;
      }}
    </AuthContext.Consumer>
  );
};

export default HeaderContent;
