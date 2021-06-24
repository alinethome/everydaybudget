import configureMockStore from 'redux-mock-store';
import { RECEIVE_ERRORS, receiveErrors } from 'frontend/actions/errors.js';

const middlewares = [];
const mockStore = configureMockStore(middlewares);

describe('receiveErrors', () => {
    test('the store should receive an action to receive the errors', () => {
        const store = mockStore({ errors: {} });
        const errors = ['This is an example of an error'];
        const expectedActions = [{
            type: RECEIVE_ERRORS,
            errors
        }];

        store.dispatch(receiveErrors(errors));
        expect(store.getActions()).toEqual(expectedActions);
    });
});
