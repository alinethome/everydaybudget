import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import { RECEIVE_BUDGET, fetchBudget } from 
'frontend/actions/budget.js';
import * as API from 'frontend/utils/budget/api_util.js';
import Budget from '../factories/budget.js';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const budget = new Budget({});
const getBudget = jest.spyOn(API, 'getBudget')
    .mockImplementation(() => {
        const fakeResponse = budget;
        return Promise.resolve(fakeResponse);
    });

describe('fetchBudget', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive the budget', () => {
        const store = mockStore({ budget: {} });
        const expectedActions = [{
            type: RECEIVE_BUDGET,
            budget
        }]

        return store.dispatch(fetchBudget()).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call fetchBudget', () => {
        const store = mockStore({ budget: {} });

        return store.dispatch(fetchBudget()).then(() => {
            expect(getBudget.mock.calls.length).toBeGreaterThan(0)
        });
    });

});
