import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import UserFormContainer from './session/user_form_container.jsx';
import NavBarContainer from './nav_bar/nav_bar_container.jsx';

const Root = ({ store }) => (
    <Provider store={ store }>
        <HashRouter>
            <div>
                <Route path='/' component={ NavBarContainer } />
                <Route path='/signup' 
                    render={ () => <UserFormContainer formType="signup" /> } />
                <Route path='/login' 
                    render={ () => <UserFormContainer formType="login" /> } />
            </div>
        </HashRouter>
    </Provider>
);

export default Root;
