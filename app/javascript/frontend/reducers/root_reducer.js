import { combineReducers } from 'redux';
import sessionReducer from './session_reducer.js';

export default combineReducers({
    session: sessionReducer
});

