import { postUser } from 'frontend/utils/session/api_util.js';
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
        jest.restoreAllMocks();
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

    test('should include the csrf token in the request', () => {
        postUser(user, token);
        expect(lastAjaxCallArgs(ajaxSpy)["notheaders"]['X-CSRF-Token']).toBe(token);
    });
});

