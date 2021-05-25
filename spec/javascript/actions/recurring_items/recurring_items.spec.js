import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import {
    RECEIVE_RECURRING_ITEMS, RECEIVE_RECURRING_ITEM,
    DELETE_RECURRING_ITEM, fetchRecurringItems, 
    createRecurringItem, updateRecurringItem, 
    destroyRecurringItem
} from 'frontend/actions/recurring_items.js';
import * as API from 'frontend/utils/budget/api_util.js';


const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const recurring1 = {
    id: 1,
    name: "A Recurring Item",
    type: "income",
    start_date: new Date(),
    end_date: null,
    amount: 1000,
    recur_period: 1,
    recur_unit_type: "MonthsUnitItem",
    month_instances: []
};

const recurring2 = {
    id: 2,
    name: "Another Recurring Item",
    type: "expense",
    start_date: new Date(),
    end_date: new Date(),
    amount: 5,
    recur_period: 7,
    recur_unit_type: "DaysUnitItem",
    month_instances: []
};
const items = [recurring1, recurring1]

const postRecurring = jest.spyOn(API, 'postRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const deleteRecurring = jest.spyOn(API, 'deleteRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const putRecurring = jest.spyOn(API, 'putRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const indexRecurring = jest.spyOn(API, 'indexRecurring')
    .mockImplementation(() => {
        const fakeResponse = items;
        return Promise.resolve(fakeResponse);
    });

describe('createRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should recieve an action to receive the item', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_RECURRING_ITEM,
            item: recurring1
        }];

        return store.dispatch(createRecurringItem(recurring1)).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call postRecurring', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});

        return store.dispatch(createRecurringItem(recurring1)).then(() =>
            expect(postRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
});

describe('updateRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive the item', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_RECURRING_ITEM,
            item: recurring1
        }];

        return store.dispatch(updateRecurringItem(recurring1)).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call putRecurring', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});

        return store.dispatch(updateRecurringItem(recurring1)).then(() =>
            expect(putRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
})

describe('destroyRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive the item', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: DELETE_RECURRING_ITEM,
            item: recurring1
        }];

        return store.dispatch(destroyRecurringItem(recurring1)).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call deleteRecurring', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});

        return store.dispatch(destroyRecurringItem(recurring1)).then(() =>
            expect(deleteRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
})

describe('fetchRecurringItems', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive all items', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_RECURRING_ITEMS,
            items
        }];

        return store.dispatch(fetchRecurringItems()).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call indexRecurring', () => {
        const store = mockStore({ entities: {
            recurring_items: {} 
        }});

        return store.dispatch(fetchRecurringItems()).then(() =>
            expect(indexRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
})
