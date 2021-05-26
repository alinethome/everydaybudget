import { combineReducers } from 'redux';
import sessionReducer from './session_reducer.js';
import entitiesReducer from './entities_reducer.js';

export default combineReducers({
    session: sessionReducer,
    entities: entitiesReducer
});

