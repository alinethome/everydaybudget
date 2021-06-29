import displayReducer from 'frontend/reducers/display_reducer.js';
import { SET_ITEM_LIST_DISPLAY } from 'frontend/actions/display.js';

describe('displayReducer', () => {
    const stateSetToRecurring = { itemList: 'recurring' };
    const stateSetToNonRecurring = { itemList: 'non-recurring' };

    
    describe('given an action for a different reducer', () => {
        test('should return the unmutated state', () => {
            const action = { type: "WRONG_ACTION" };
            const state = stateSetToNonRecurring;

            expect(displayReducer(state, action)).toEqual(state);
        });
    })

    describe('given an action of the SET_ITEM_LIST_DISPLAY type', () => {
        test('returns a state with itemList set to the recur type', () => {
            const actionForSettingToRecurring = { 
                type: "SET_ITEM_LIST_DISPLAY",
                itemList: "recurring"
            };

            const actionForSettingToNonRecurring = { 
                type: "SET_ITEM_LIST_DISPLAY",
                itemList: "non-recurring"
            };

            expect(displayReducer(stateSetToNonRecurring,
                actionForSettingToRecurring))
                .toEqual(stateSetToRecurring);

            expect(displayReducer(stateSetToRecurring,
                actionForSettingToNonRecurring))
                .toEqual(stateSetToNonRecurring);

        });

    });
});
