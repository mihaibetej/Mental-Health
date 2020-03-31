import React, {useEffect, useState} from 'react';
import {AuthContext} from '../contexts';
import firebase from "../db"

const withAuthentication = Component => {
  const WithAuthentication = (props) => {
    const [authUser, setAuthUser] = useState(null);

    useEffect(() => {
      const unsubscribe = firebase.auth().onAuthStateChanged(
        authUser => {
          authUser
            ? setAuthUser(authUser)
            : setAuthUser(null );
        },
      );
      return unsubscribe;
    }, []);

    return (
      <AuthContext.Provider value={authUser}>
        <Component {...props} />
      </AuthContext.Provider>
    )
  }

  return WithAuthentication;
};
export default withAuthentication;