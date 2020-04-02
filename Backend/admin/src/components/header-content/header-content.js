import React from 'react';
import { isNil } from 'lodash';

import { AuthContext } from '../../contexts';

import './header-content.css';

const HeaderContent = ({ children }) => {
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
          </div>
        ) : null;
      }}
    </AuthContext.Consumer>
  );
};

export default HeaderContent;
