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
        notheaders: { 'X-CSRF-Token': token }
    });
};


