import { postUser } from '../utils/session/api_util.js';

export const RECEIVE_CURRENT_USER = "RECEIVE_CURRENT_USER";

const receiveCurrentUser = (user) => ({
    type: RECEIVE_CURRENT_USER,
    user
});

export const createNewUser = (newUser) => (dispatch) => {
    return postUser(newUser)
        .then((createdUser) => dispatch(receiveCurrentUser(createdUser)));
};



