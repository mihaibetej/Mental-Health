import React from 'react';
import { isNil } from 'lodash';

import { AuthContext } from '../../contexts';

const HeaderContent = () => {
  return (
    <AuthContext.Consumer>
      {(authUser) => {
        // todo: add logout button
        return !isNil(authUser) ? (
          <div style={{ color: 'white' }}>
            Welcome &nbsp;
            {authUser && authUser.email}
          </div>
        ) : null;
      }}
    </AuthContext.Consumer>
  );
};

export default HeaderContent;
