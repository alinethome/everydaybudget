import {
    RECEIVE_RECURRING_ITEMS,
    RECEIVE_RECURRING_ITEM,
    DELETE_RECURRING_ITEM
} from '../actions/recurring_items.js';

import itemsReducer from './items_reducer.js';

const receiveSingle = RECEIVE_RECURRING_ITEM;
const receiveMultiple = RECEIVE_RECURRING_ITEMS;
const deleteSingle = DELETE_RECURRING_ITEM;

const recurringItemsReducer = itemsReducer({
    receiveSingle,
    receiveMultiple,
    deleteSingle
});

export default recurringItemsReducer;
