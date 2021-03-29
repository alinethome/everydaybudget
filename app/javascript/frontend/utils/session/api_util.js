import $ from 'jquery';


export const postUser = (user, token) => {
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

export const postSession = (user, token) => {
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


