import errorsReducer from 'frontend/reducers/errors_reducer.js';
import { RECEIVE_ERRORS } from 'frontend/actions/errors.js';

describe('errorsReducer', () => {
    const errors = ['An email error', 'A password error'];

    describe('given an action for a different reducer', () => {
        test('should return the unmutated state', () => {
            const action = { type: "WRONG ACTION" };
            const state = [];

            expect(errorsReducer(state, action)).toEqual(state);
        });

    });

    describe('given an action of the RECEIVE_ERRORS type', () => {
        const action = { type: RECEIVE_ERRORS, errors };
        const initialState = ["an error that shouldn't persist"];
        const expectedState = errors;

        test('it should return a new state with the new errors', () => {
            expect(errorsReducer(initialState, action)).toEqual(expectedState);
        });

        test('it shouldn\'t mutate the input state', () => {
            expect(errorsReducer(initialState, action))
                .not.toBe(initialState);
        });
    });
});
