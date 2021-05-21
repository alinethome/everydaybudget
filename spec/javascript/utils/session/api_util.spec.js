import { postUser, postSession, 
    deleteSession } from 'frontend/utils/session/api_util.js';
import $ from 'jquery';

describe('postUser', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token';
    const email = 'email@email.com';
    const password = 'password';
    const user = {
        email,
        password
    }
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

    test('should send user data', () => {
        postUser(user);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["email"]).toBe(email)
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["password"]).toBe(password)
    });

    test('should make a post request', () => {
        postUser(user);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the users api url', () => {
        postUser(user);
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/users/');
    });

    test('should include the csrf token in the request', () => {
        postUser(user);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token']).toBe(token);
    });
});

describe('postSession', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token';
    const email = 'email@email.com';
    const password = 'password';
    const user = {
        email,
        password
    }
    let metaElement;

    jest.spyOn(document, 'getElementsByName').mockReturnValue([{ content: token }]);
    
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

    test('should send user data', () => {
        postSession(user);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["email"]).toBe(email)
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["password"]).toBe(password)
    });

    test('should make a post request', () => {
        postSession(user);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the session api url', () => {
        postSession(user);
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/session/');
    });

    test('should include the csrf token in the request', () => {
        postSession(user);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token']).toBe(token);
    });
});

describe('deleteSession', () => {
    const ajaxSpy = jest.spyOn($, 'ajax');
    const token = 'token';
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
        deleteSession();
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('DELETE');
    });
    
    test('should make the request to the session api url', () => {
        deleteSession();
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/session/');
    });

    test('should include the csrf token in the request', () => {
        deleteSession();
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token']).toBe(token);
    });
});
