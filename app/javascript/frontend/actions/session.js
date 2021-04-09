import { postUser, postSession, deleteSession } from '../utils/session/api_util.js';

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";
export const LOGOUT_CURRENT_USER = "LOGOUT_CURRENT_USER";

const receiveCurrentUser = (user) => ({
    type: RECEIVE_CURRENT_USER,
    user
});

const logoutCurrentUser = () => ({
    type: LOGOUT_CURRENT_USER
});

export const createNewUser = (newUser) => (dispatch) => {
    return postUser(newUser)
        .then((createdUser) => dispatch(receiveCurrentUser(createdUser)));
};

export const login = (formUser) => (dispatch) => {
    return postSession(formUser)
        .then((user) => dispatch(receiveCurrentUser(user)));
};

export const logout = () => (dispatch) => {
    return deleteSession()
        .then(() => dispatch(logoutCurrentUser()));
};




