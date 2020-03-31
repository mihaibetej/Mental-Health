import { ref, firebaseAuth } from './index'
import { prop, pipe, __ } from 'lodash/fp';

const providers = {
  "google": firebaseAuth.GoogleAuthProvider,
  "facebook": firebaseAuth.FacebookAuthProvider,
}

const getProviderByOauthId = prop(__, providers);
const createProvider = provider => new provider();

export const logout = () => firebaseAuth.signOut();
export const login = (email, pw) => firebaseAuth().signInWithEmailAndPassword(email, pw);
export const loginPopup = (provider)=> firebaseAuth().signInWithPopup(provider)
  .then((userCredentials)=> console.log('loggedIn', userCredentials))
  .catch((err)=> console.log('err', err))

export const loginOauth = pipe( getProviderByOauthId, createProvider, loginPopup)
