import {
    RECEIVE_NON_RECURRING_ITEMS,
    RECEIVE_NON_RECURRING_ITEM,
    DELETE_NON_RECURRING_ITEM
} from '../actions/non_recurring_items.js';
import itemsReducer from './items_reducer.js';

const receiveSingle = RECEIVE_NON_RECURRING_ITEM;
const receiveMultiple = RECEIVE_NON_RECURRING_ITEMS;
const deleteSingle = DELETE_NON_RECURRING_ITEM;

const nonRecurringItemsReducer = itemsReducer({
    receiveSingle,
    receiveMultiple,
    deleteSingle
});

export default nonRecurringItemsReducer;
