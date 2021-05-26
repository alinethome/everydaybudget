import recurringItemsReducer from 
'frontend/reducers/recurring_items_reducer.js';
import {
    RECEIVE_RECURRING_ITEMS,
    RECEIVE_RECURRING_ITEM,
    DELETE_RECURRING_ITEM
} from 'frontend/actions/recurring_items.js';
import RecurringItem from '../factories/recurring_item.js';

describe('recurring items reducer', () => {
    const recurringItem1 = new RecurringItem({ id: 1 });
    const recurringItem2 = new RecurringItem({ id: 2 });
    const recurringItem3 = new RecurringItem({ id: 3 });

    describe('given an action for a different object', () => {
        test('should return the unmutated state', () => {
            const action = { type: 'WRONG_ACTION' };
            const state = {
                1: recurringItem1,
                2: recurringItem2,
                3: recurringItem3
            };

            expect(recurringItemsReducer(state, action)).toEqual(state);
        });
    });

    describe('given an action of the RECEIVE_RECURRING_ITEMS type', () => {
            const items = [recurringItem1, recurringItem2, recurringItem3];
            const action = { type: RECEIVE_RECURRING_ITEMS, items };
            const initialState = {};
            const expectedState = {
                [items[0].id]: items[0],
                [items[1].id]: items[1],
                [items[2].id]: items[2]
            };

        test('should return a new state with the new items', () => {
            expect(recurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(recurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });
    });

    describe('given an action of the RECEIVE_RECURRING_ITEM type', () => {
            const item = recurringItem1;
            const action = { type: RECEIVE_RECURRING_ITEM, item };
            const initialState = {};
            const expectedState = {
                1: item,
            };

        test('should return a new state with the new item', () => {
            expect(recurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(recurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });

        describe('if the state already has an object with that id', () => {
            it('returns a state with the new item', () => {
                const stateWithItem = { 1: recurringItem1 };
                const newItem = new RecurringItem({ id: 1, amount: 0 });
                const action = { type: RECEIVE_RECURRING_ITEM, item: newItem };

                expect(recurringItemsReducer(initialState, action)[1])
                    .toEqual(newItem);
            });
        });
    });

    describe('given an action of the DELETE_RECURRING_ITEM type', () => {
        const item = recurringItem1;
        const action = { type: DELETE_RECURRING_ITEM, item };
        const initialState = {
            1: item,
        };
        const expectedState = {};

        test('should return a new state without the deleted item', () => {
            expect(recurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(recurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });
    });
});
