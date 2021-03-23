import React from 'react';
import { HashRouter, Route } from 'react-router-dom';
import SignUp from './session/sign_up.jsx';

const Root = () => (
    <HashRouter>
        <div>
            <Route path='/register' component={ SignUp } />
        </div>
    </HashRouter>
);

export default Root;
