import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import SignUp from './session/sign_up.jsx';

const Root = ({ store }) => (
    <Provider store={ store }>
        <HashRouter>
            <div>
                <Route path='/register' component={ SignUp } />
            </div>
        </HashRouter>
    </Provider>
);

export default Root;
