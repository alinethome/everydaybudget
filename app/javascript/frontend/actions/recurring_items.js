import { 
    postRecurring, putRecurring,
    deleteRecurring, indexRecurring
} from '../utils/budget/api_util.js';

export const RECEIVE_RECURRING_ITEMS = "RECEIVE_RECURRING_ITEMS";
export const RECEIVE_RECURRING_ITEM = "RECEIVE_RECURRING_ITEM";
export const DELETE_RECURRING_ITEM = "DELETE_RECURRING_ITEM";

const receiveRecurringItems = (items) => ({
    type: RECEIVE_RECURRING_ITEMS,
    items
});

const receiveRecurringItem = (item) => ({
    type: RECEIVE_RECURRING_ITEM,
    item
});

const deleteRecurringItem = (item) => ({
    type: DELETE_RECURRING_ITEM,
    item
});

export const fetchRecurringItems = () => (dispatch) => {
    return indexRecurring()
    .then((items) => dispatch(receiveRecurringItems(items)))
};

export const createRecurringItem = (item) => (dispatch) => {
    return postRecurring(item)
    .then((createdItem) => dispatch(receiveRecurringItem(createdItem)));
};

export const destroyRecurringItem = (item) => (dispatch) => {
    return deleteRecurring(item) 
        .then((deletedItem) => dispatch(deleteRecurringItem(deletedItem)));
};

export const updateRecurringItem  = (item) => (dispatch) => {
    return putRecurring(item)
    .then((createdItem) => dispatch(receiveRecurringItem(createdItem)));
};

