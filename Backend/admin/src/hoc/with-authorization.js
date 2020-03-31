import React, {useEffect} from 'react';
import {isNil} from 'lodash';
import {useHistory} from "react-router"
import {AuthContext} from '../contexts';
import firebase from "../db"

// OR we can move this on route level and enhance `Route` or `Match` components from React-router instead @components level
const withAuthorization = Component => {
  const WithAuthorization = (props) => {
    const history = useHistory();

    useEffect(() => {
      const unsubscribe = firebase.auth().onAuthStateChanged(
        authUser => {
         if(isNil(authUser)) {
           history.push('/login')
         }
        },
      );
      return unsubscribe;
    });

    return (
      <AuthContext.Consumer>
        {authUser =>
          !isNil(authUser) ? <Component {...props} /> : null
        }
      </AuthContext.Consumer>
    )
  }

  return WithAuthorization;
};
export default withAuthorization;