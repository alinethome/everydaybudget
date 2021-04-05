import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import { createNewUser, RECEIVE_CURRENT_USER } from 'frontend/actions/session.js';
import $ from 'jquery';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const id = 1;
$.ajax = jest.fn().mockImplementation(() => {
    const fakeResponse = {
        id,
        email: "anemail@email.com"
    };
    return Promise.resolve(fakeResponse);
});

describe('createNewUser', () => {
    afterEach(() => {
        jest.resetAllMocks();
    });

    test('the store should receive an action to update current user', () => {
        const store = mockStore({ session: { current_user: {} } });
        const user = { email: 'anemail@email.com', password: 'password' }
        const expectedActions = [{ 
            type: RECEIVE_CURRENT_USER, 
            user: { email: user.email, id } 
        }];

        return store.dispatch(createNewUser(user)).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });
});
