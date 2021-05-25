import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import {
    RECEIVE_NON_RECURRING_ITEMS, RECEIVE_NON_RECURRING_ITEM,
    DELETE_NON_RECURRING_ITEM, fetchNonRecurringItems, 
    createNonRecurringItem, updateNonRecurringItem, 
    destroyNonRecurringItem
} from 'frontend/actions/non_recurring_items.js';
import * as API from 'frontend/utils/budget/api_util.js';
import NonRecurringItem from '../factories/non_recurring_item.js';

const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const non_recurring1 = new NonRecurringItem({ id: 1 });
const non_recurring2 = new NonRecurringItem({ id: 2 });
const items = [non_recurring1, non_recurring2]

const postNonRecurring = jest.spyOn(API, 'postNonRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const deleteNonRecurring = jest.spyOn(API, 'deleteNonRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const putNonRecurring = jest.spyOn(API, 'putNonRecurring')
    .mockImplementation((item) => {
        const fakeResponse = item;
        return  Promise.resolve(fakeResponse);
    });

const indexNonRecurring = jest.spyOn(API, 'indexNonRecurring')
    .mockImplementation(() => {
        const fakeResponse = items;
        return Promise.resolve(fakeResponse);
    });

describe('createNonRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should recieve an action to receive the item', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_NON_RECURRING_ITEM,
            item: non_recurring1
        }];

        return store.dispatch(createNonRecurringItem(non_recurring1)).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call postNonRecurring', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});

        return store.dispatch(createNonRecurringItem(non_recurring1)).then(() =>
            expect(postNonRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
});

describe('updateNonRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive the item', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_NON_RECURRING_ITEM,
            item: non_recurring1
        }];

        return store.dispatch(updateNonRecurringItem(non_recurring1))
            .then(() => 
                expect(store.getActions()).toEqual(expectedActions)
            );
    });

    test('should call putNonRecurring', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});

        return store.dispatch(updateNonRecurringItem(non_recurring1)).then(() =>
            expect(putNonRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
})

describe('destroyNonRecurringItem', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive the item', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: DELETE_NON_RECURRING_ITEM,
            item: non_recurring1
        }];

        return store.dispatch(destroyNonRecurringItem(non_recurring1))
            .then(() => 
                expect(store.getActions()).toEqual(expectedActions)
            );
    });

    test('should call deleteNonRecurring', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});

        return store.dispatch(destroyNonRecurringItem(non_recurring1))
            .then(() =>
                expect(deleteNonRecurring.mock.calls.length).toBeGreaterThan(0)
            );
    });
})

describe('fetchNonRecurringItems', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    test('the store should receive an action to receive all items', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});
        const expectedActions = [{ 
            type: RECEIVE_NON_RECURRING_ITEMS,
            items
        }];

        return store.dispatch(fetchNonRecurringItems()).then(() => 
            expect(store.getActions()).toEqual(expectedActions)
        );
    });

    test('should call indexNonRecurring', () => {
        const store = mockStore({ entities: {
            non_recurring_items: {} 
        }});

        return store.dispatch(fetchNonRecurringItems()).then(() =>
            expect(indexNonRecurring.mock.calls.length).toBeGreaterThan(0)
        );
    });
})
