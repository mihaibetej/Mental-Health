import firebase from './index'
import { prop, pipe, __ } from 'lodash/fp';

const providers = {
  "google": firebase.auth().GoogleAuthProvider,
  "facebook": firebase.auth().FacebookAuthProvider,
}

const getProviderByOauthId = prop(__, providers);
const createProvider = provider => new provider();

export const logout = () => firebase.auth().signOut();

export const login = (email, pw) => firebase.auth().signInWithEmailAndPassword(email, pw);

export const loginPopup = (provider)=> firebase.auth().signInWithPopup(provider)
  .then((userCredentials)=> console.log('loggedIn', userCredentials))
  .catch((err)=> console.log('err', err))

export const loginOauth = pipe( getProviderByOauthId, createProvider, loginPopup)
