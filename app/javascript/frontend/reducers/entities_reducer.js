import { combineReducers } from 'redux';
import recurringItemsReducer from './recurring_items_reducer.js';
import nonRecurringItemsReducer from './non_recurring_items_reducer.js';

export default combineReducers({
    recurringItems: recurringItemsReducer,
    nonRecurringItems: nonRecurringItemsReducer,
});
