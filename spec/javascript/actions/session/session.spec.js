import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import { 
    createNewUser, RECEIVE_CURRENT_USER,
    logout, LOGOUT_CURRENT_USER
} from 'frontend/actions/session.js';
import * as API from 'frontend/utils/session/api_util.js';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const id = 1;

const postUser = jest.spyOn(API, 'postUser')
    .mockImplementation(() => {
        const fakeResponse = {
            id,
            email: "anemail@email.com"
        };
        return Promise.resolve(fakeResponse);
    });

const deleteSession = jest.spyOn(API, 'deleteSession')
    .mockImplementation(() => {
        const fakeResponse = "";
        return Promise.resolve(fakeResponse);
    });

describe('createNewUser', () => {
    afterEach(() => {
        jest.clearAllMocks();
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

    test('should call postUser', () => {
        const store = mockStore({ session: { current_user: {} } });
        const user = { email: 'anemail@email.com', password: 'password' }

        return store.dispatch(createNewUser(user)).then(() => 
            expect(postUser.mock.calls.length).toBeGreaterThan(0)
        );
    });
});

describe('logout', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to logout the current user', () => {
        const store = mockStore({ session: { current_user: {} } });
        const expectedActions = [{ 
            type: LOGOUT_CURRENT_USER
        }];

        return store.dispatch(logout()).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call deleteUser', () => {
        const store = mockStore({ session: { current_user: {} } });

        return store.dispatch(logout()).then(() => 
            expect(deleteSession.mock.calls.length).toBeGreaterThan(0)
        );
    });
});
