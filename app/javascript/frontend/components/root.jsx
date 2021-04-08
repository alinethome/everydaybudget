import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import SignUpContainer from './session/sign_up_container.jsx';
import NavBarContainer from './nav_bar/nav_bar_container.jsx';

const Root = ({ store }) => (
    <Provider store={ store }>
        <HashRouter>
            <div>
                <Route path='/' component={ NavBarContainer } />
                <Route path='/register' component={ SignUpContainer } />
            </div>
        </HashRouter>
    </Provider>
);

export default Root;
