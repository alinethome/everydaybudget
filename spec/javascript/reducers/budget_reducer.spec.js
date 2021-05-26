import budgetReducer from 'frontend/reducers/budget_reducer.js';
import { RECEIVE_BUDGET } from 'frontend/actions/budget.js';
import Budget from '../factories/budget.js';

describe('budgetReducer', () => {
    const budget = new Budget({});

    describe('given an action for a different reducer', () => {
        test('should return the unmutated state', () => {
            const action = { type: 'WRONG_ACTION' };
            const state = budget;

            expect(budgetReducer(state, action)).toEqual(state);
        });
    });

    describe('given an action of the RECEIVE_BUDGET type', () => {
        const action = { type: RECEIVE_BUDGET, budget };
        const initialState = {};
        const expectedState = budget;

        test('should return a new state with the new budget', () => {
            expect(budgetReducer(initialState, action))
                .toEqual(expectedState);
        });

        test('should not mutate the input state', () => {
            expect(budgetReducer(initialState, action))
                .not.toBe(initialState);
        });
    });
})
