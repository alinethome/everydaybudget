import $ from 'jquery';

const getToken = () => {
    return document.querySelector('meta[name="csrf-token"]')
        .getAttribute('content');
};

export const postUser = (user) => {
    let token = getToken();

    return $.ajax({
        url: '/api/users/',
        method: 'POST',
        data: { 'user': 
            { 
                'email': user.email,
                'password': user.password
            } 
        },
        headers: { 'X-CSRF-Token': token }
    });
};

export const postSession = (user) => {
    let token = getToken();

    return $.ajax({
        url: '/api/session/',
        method: 'POST',
        data: { 'user': 
            { 
                'email': user.email,
                'password': user.password
            } 
        },
        headers: { 'X-CSRF-Token': token }
    });
};

export const deleteSession = () => {
    let token = getToken();

    return $.ajax({
        url: '/api/session/',
        method: 'DELETE',
        headers: { 'X-CSRF-Token': token }
    });
};

