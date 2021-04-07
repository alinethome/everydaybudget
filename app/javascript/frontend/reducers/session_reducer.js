import {
    RECEIVE_CURRENT_USER, createNewUser,
    LOGOUT_CURRENT_USER
} from '../actions/session.js';

const nullSession = {
    current_user: null
};

const sessionReducer = (state = nullSession, action) => {
    Object.freeze(state);
    switch(action.type) {
        case RECEIVE_CURRENT_USER: 
            return { current_user: action.user };
        case LOGOUT_CURRENT_USER:
            return { current_user: null };
        default:
            return state;
    };
};

export default sessionReducer;
