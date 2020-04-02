import React from 'react';
import { isNil } from 'lodash';

import { AuthContext } from '../../contexts';
import { Link } from 'react-router-dom';

const navigationLink = {
  marginRight: '10px',
  color: 'white',
};

const HeaderContent = () => {
  return (
    <AuthContext.Consumer>
      {(authUser) => {
        // todo: add logout button
        return !isNil(authUser) ? (
          <div
            style={{
              color: 'white',
              display: 'flex',
              justifyContent: 'space-between',
            }}
          >
            {' '}
            Welcome &nbsp;
            {authUser && authUser.email}
            <div style={{ display: 'flex', justifyContent: 'space-around' }}>
              <Link to="/questions" style={navigationLink}>
                Questions
              </Link>
              <Link to="/answers" style={navigationLink}>
                Answers
              </Link>
              <Link to="/news" style={navigationLink}>
                News
              </Link>
              <Link to="/dailyAdvices" style={navigationLink}>
                Daily advices
              </Link>
              <Link to="/messages" style={navigationLink}>
                Messages
              </Link>
            </div>
          </div>
        ) : null;
      }}
    </AuthContext.Consumer>
  );
};

export default HeaderContent;
