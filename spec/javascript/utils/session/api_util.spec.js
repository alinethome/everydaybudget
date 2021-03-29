import { postUser, postSession, deleteSession } from 'frontend/utils/session/api_util.js';
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
    
    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send user data', () => {
        postUser(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["email"]).toBe(email)
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["password"]).toBe(password)
    });

    test('should make a post request', () => {
        postUser(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the users api url', () => {
        postUser(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/users/');
    });

    test('should include the csrf token in the request', () => {
        postUser(user, token);
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
    
    const lastAjaxCallArgs = (spy) => {
        let calls = spy.mock.calls;
        let last = calls.length - 1;

        return calls[last][0];
    };

    afterEach(() => {
        jest.resetAllMocks();
    });

    test('should send user data', () => {
        postSession(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["email"]).toBe(email)
        expect(lastAjaxCallArgs(ajaxSpy)["data"]["user"]["password"]).toBe(password)
    });

    test('should make a post request', () => {
        postSession(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["method"]).toBe('POST');
    });

    test('should make the request to the session api url', () => {
        postSession(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["url"]).toBe('/api/session/');
    });

    test('should include the csrf token in the request', () => {
        postSession(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["headers"]['X-CSRF-Token']).toBe(token);
    });
});

describe('deleteSession', () => {
});
