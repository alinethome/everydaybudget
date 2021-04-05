import sessionReducer from 'frontend/reducers/session_reducer.js';
import { RECEIVE_CURRENT_USER } from 'frontend/actions/session.js';

describe('session reducer', () => {
    const id = 1;
    const email = 'anemail@email.com';

    describe('given a non-session action', () => {
        test('should return the unmutated state', () => {
            const action = { type: 'NON_SESSION_ACTION' };
            const state = { current_user: {
                id,
                email
            }};

            expect(sessionReducer(state, action)).toEqual(state);
        })
    });

    describe('given an action with the RECEIVE_CURRENT_USER type', () => {
        test('should return a new state with the user that was passed', () => {
            const user = { id, email }
            const action = { type: RECEIVE_CURRENT_USER, user }
            const state = { current_user: null }

            expect(sessionReducer(state, action).current_user).toEqual(user);
        });
    });
});
