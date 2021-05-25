import { 
    postRecurring,
    postNonRecurring,
    putRecurring,
    putNonRecurring,
    deleteRecurring,
    deleteNonRecurring,
    getRecurring,
    getNonRecurring,
    indexRecurring,
    indexNonRecurring,
    getBudget
} from 'frontend/utils/budget/api_util.js';
import $ from 'jquery';

describe('postRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        name: "Recurring Item",
        type: "income",
        amount: 10,
        start_date: today,
        end_date: null,
        recur_period: 5,
        recur_unit_type: "DaysUnitItem"
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send item data', () => {
        postRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["item"]).toBe(item);
    });

    test('should make a post request', () => {
        postRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the recurring item url', () => {
        postRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/recurring_items');
    });

    test('should include the csrf token in the request', () => {
        postRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
});

describe('postNonRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        name: "Non Recurring Item",
        type: "expense",
        amount: 10,
        date: today,
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send item data', () => {
        postNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["item"]).toBe(item);
    });

    test('should make a post request', () => {
        postNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the non recurring item url', () => {
        postNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe('/api/non_recurring_items');
    });

    test('should include the csrf token in the request', () => {
        postNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
});

describe('putRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        id: 3,
        name: "Recurring Item",
        type: "income",
        amount: 10,
        start_date: today,
        end_date: null,
        recur_period: 5,
        recur_unit_type: "DaysUnitItem"
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send item data', () => {
        putRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["item"]).toBe(item);
    });

    test('should make a put request', () => {
        putRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('PUT');
    });

    test('should make the request to the item\'s url', () => {
        putRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/recurring_items/${item.id}`);
    });

    test('should include the csrf token in the request', () => {
        putRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
});

describe('putNonRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        id: 3,
        name: "Non Recurring Item",
        type: "expense",
        amount: 10,
        date: today,
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send item data', () => {
        putNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["item"]).toBe(item);
    });

    test('should make a put request', () => {
        putNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('PUT');
    });

    test('should make the request to the item\'s url', () => {
        putNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/non_recurring_items/${item.id}`);
    });

    test('should include the csrf token in the request', () => {
        putNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
})


describe('deleteRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        id: 3,
        name: "Non Recurring Item",
        type: "expense",
        amount: 10,
        date: today,
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a delete request', () => {
        deleteRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('DELETE');
    });

    test('should make the request to the item\'s url', () => {
        deleteRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/recurring_items/${item.id}`);
    });

    test('should include the csrf token in the request', () => {
        deleteRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
})

describe('deleteNonRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let today = new Date();
    const item = {
        id: 3,
        name: "Non Recurring Item",
        type: "expense",
        amount: 10,
        date: today,
    };
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a delete request', () => {
        deleteNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('DELETE');
    });

    test('should make the request to the item\'s url', () => {
        deleteNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/non_recurring_items/${item.id}`);
    });

    test('should include the csrf token in the request', () => {
        deleteNonRecurring(item);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token'])
            .toBe(token);
    });
});

describe('getRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    const id = 3;
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a get request', () => {
        getRecurring(id);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('GET');
    });

    test('should make the request to the item\'s url', () => {
        getRecurring(id);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/recurring_items/${id}`);
    });
});

describe('getNonRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    const id = 3;
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a get request', () => {
        getNonRecurring(id);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('GET');
    });

    test('should make the request to the item\'s url', () => {
        getNonRecurring(id);
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/non_recurring_items/${id}`);
    });
});

describe('indexRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a get request', () => {
        indexRecurring();
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('GET');
    });

    test('should make the request to the recurring items url', () => {
        indexRecurring();
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/recurring_items`);
    });
});

describe('indexNonRecurring', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    afterAll(() => {
        metaElement.remove();
    });

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should make a get request', () => {
        indexNonRecurring();
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('GET');
    });

    test('should make the request to the non-recurring items url', () => {
        indexNonRecurring();
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe(`/api/non_recurring_items`);
    });
})

describe('getBudget', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token'
    let metaElement;

    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    beforeAll(() => {
        metaElement = document.createElement("meta");
        metaElement.name = 'csrf-token';
        metaElement.content = token;
        document.head.append(metaElement);
    });

    test('should make a get request', () => {
        getBudget();
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('GET')

    });

    test('should make a request to the budget url', () => {
        getBudget();
        expect(lastAjaxCallArgs(ajaxSpy)["url"])
            .toBe('/api/budget')
    });
});
