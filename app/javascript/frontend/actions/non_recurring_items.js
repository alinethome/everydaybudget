import {
    postNonRecurring, putNonRecurring,
    deleteNonRecurring, indexNonRecurring
} from '../utils/budget/api_util.js';

export const RECEIVE_NON_RECURRING_ITEM = "RECEIVE_NON_RECURRING_ITEM";
export const RECEIVE_NON_RECURRING_ITEMS = "RECEIVE_NON_RECURRING_ITEMS";
export const DELETE_NON_RECURRING_ITEM = "DELETE_NON_RECURRING_ITEM";

const receiveNonRecurringItems = (items) => ({
    type: RECEIVE_NON_RECURRING_ITEMS,
    items
});

const receiveNonRecurringItem = (item) => ({
    type: RECEIVE_NON_RECURRING_ITEM,
    item
});

const deleteNonRecurringItem = (item) => ({
    type: DELETE_NON_RECURRING_ITEM,
    item
});

export const fetchNonRecurringItems = () => (dispatch) => {
    return indexNonRecurring()
    .then((items) => dispatch(receiveNonRecurringItems(items)))
};

export const createNonRecurringItem = (item) => (dispatch) => {
    return postNonRecurring(item)
    .then((createdItem) => dispatch(receiveNonRecurringItem(createdItem)));
};

export const destroyNonRecurringItem = (item) => (dispatch) => {
    return deleteNonRecurring(item) 
        .then((deletedItem) => dispatch(deleteNonRecurringItem(deletedItem)));
};

export const updateNonRecurringItem  = (item) => (dispatch) => {
    return putNonRecurring(item)
    .then((createdItem) => dispatch(receiveNonRecurringItem(createdItem)));
};

