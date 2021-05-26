import nonRecurringItemsReducer from 
'frontend/reducers/non_recurring_items_reducer.js';
import {
    RECEIVE_NON_RECURRING_ITEMS,
    RECEIVE_NON_RECURRING_ITEM,
    DELETE_NON_RECURRING_ITEM
} from 'frontend/actions/non_recurring_items.js';
import NonRecurringItem from '../factories/non_recurring_item.js';

describe('non-recurring items reducer', () => {
    const nonRecurringItem1 = new NonRecurringItem({ id: 1 });
    const nonRecurringItem2 = new NonRecurringItem({ id: 2 });
    const nonRecurringItem3 = new NonRecurringItem({ id: 3 });

    describe('given an action for a different object', () => {
        test('should return the unmutated state', () => {
            const action = { type: 'WRONG_ACTION' };
            const state = {
                1: nonRecurringItem1,
                2: nonRecurringItem2,
                3: nonRecurringItem3
            };

            expect(nonRecurringItemsReducer(state, action)).toEqual(state);
        });
    });

    describe('given an action of the RECEIVE_NON_RECURRING_ITEMS type', () => {
            const items = [
                nonRecurringItem1, 
                nonRecurringItem2, 
                nonRecurringItem3
            ];
            const action = { type: RECEIVE_NON_RECURRING_ITEMS, items };
            const initialState = {};
            const expectedState = {
                [items[0].id]: items[0],
                [items[1].id]: items[1],
                [items[2].id]: items[2]
            };

        test('should return a new state with the new items', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });
    });

    describe('given an action of the RECEIVE_NON_RECURRING_ITEM type', () => {
            const item = nonRecurringItem1;
            const action = { type: RECEIVE_NON_RECURRING_ITEM, item };
            const initialState = {};
            const expectedState = {
                1: item,
            };

        test('should return a new state with the new item', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });

        describe('if the state already has an object with that id', () => {
            it('returns a state with the new item', () => {
                const stateWithItem = { 1: nonRecurringItem1 };
                const newItem = new NonRecurringItem({ id: 1, amount: 0 });
                const action = { 
                    type: RECEIVE_NON_RECURRING_ITEM, 
                    item: newItem 
                };

                expect(nonRecurringItemsReducer(initialState, action)[1])
                    .toEqual(newItem);
            });
        });
    });

    describe('given an action of the DELETE_NON_RECURRING_ITEM type', () => {
        const item = nonRecurringItem1;
        const action = { type: DELETE_NON_RECURRING_ITEM, item };
        const initialState = {
            1: item,
        };
        const expectedState = {};

        test('should return a new state without the deleted item', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should return a new state object', () => {
            expect(nonRecurringItemsReducer(initialState, action))
                .not.toBe(initialState);
        });
    });
});

