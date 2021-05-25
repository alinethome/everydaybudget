import $ from 'jquery';

const getToken = () => {
    return document.querySelector('meta[name="csrf-token"]')
        .getAttribute('content');
};

export const postRecurring = (item) => {
    let token = getToken();

    return $.ajax({
        url: '/api/recurring_items',
        method: 'POST',
        data: { 'item': item },
        headers: { 'X-CSRF-Token': token }
    });
};

export const postNonRecurring = (item) => {
    let token = getToken();

    return $.ajax({
        url: '/api/non_recurring_items',
        method: 'POST',
        data: { 'item': item },
        headers: { 'X-CSRF-Token': token }
    });
};

export const putRecurring = (item) =>  {
    let token = getToken();

    return $.ajax({
        url: `/api/recurring_items/${item.id}`,
        method: 'PUT',
        data: { 'item': item },
        headers: { 'X-CSRF-Token': token }
    });
};

export const putNonRecurring = (item) =>  {
    let token = getToken();

    return $.ajax({
        url: `/api/non_recurring_items/${item.id}`,
        method: 'PUT',
        data: { 'item': item },
        headers: { 'X-CSRF-Token': token }
    });
};

export const deleteRecurring = (item) =>  {
    let token = getToken();

    return $.ajax({
        url: `/api/recurring_items/${item.id}`,
        method: 'DELETE',
        headers: { 'X-CSRF-Token': token }
    });
};

export const deleteNonRecurring = (item) =>  {
    let token = getToken();

    return $.ajax({
        url: `/api/non_recurring_items/${item.id}`,
        method: 'DELETE',
        headers: { 'X-CSRF-Token': token }
    });
};

export const getRecurring = (itemId) =>  {
    return $.ajax({
        url: `/api/recurring_items/${itemId}`,
        method: 'GET'
    });
};

export const getNonRecurring = (itemId) =>  {
    return $.ajax({
        url: `/api/non_recurring_items/${itemId}`,
        method: 'GET',
    });
};

export const indexRecurring = () =>  {
    return $.ajax({
        url: `/api/recurring_items`,
        method: 'GET'
    });
};

export const indexNonRecurring = () =>  {
    return $.ajax({
        url: `/api/non_recurring_items`,
        method: 'GET'
    });
};

export const getBudget = () =>  {
    return $.ajax({
        url: `/api/budget`,
        method: 'GET'
    });
};
