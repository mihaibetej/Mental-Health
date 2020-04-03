import React, { useEffect, useState } from 'react';
import { AuthContext } from '../contexts';
import firebase from '../db';

const withAuthentication = (Component) => {
  const WithAuthentication = (props) => {
    const [authUser, setAuthUser] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
      const unsubscribe = firebase.auth().onAuthStateChanged((user) => {
        if (user) {
          setAuthUser(user);
          setLoading(false);
        } else {
          setAuthUser(null);
          setLoading(false);
        }
      });

      return unsubscribe;
    }, []);

    return (
      <AuthContext.Provider value={authUser}>
        <Component {...props} authUser={authUser} authLoading={loading} />
      </AuthContext.Provider>
    );
  };

  return WithAuthentication;
};
export default withAuthentication;
