import React from 'react';
import ReactDOM from 'react-dom';
import Root from './components/root.jsx';
import configureStore from './store/store.js';

document.addEventListener("DOMContentLoaded", () => {
    let preloadedState;

    if (window.currentUser) {
        preloadedState = {
            session: {
                current_user: window.currentUser
            }
        };
    }

    const store = configureStore(preloadedState);

    ReactDOM.render(<Root store={ store } />, document.getElementById('root'));
});
