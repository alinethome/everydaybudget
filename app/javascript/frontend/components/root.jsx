import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import UserFormContainer from './session/user_form_container.jsx';
import NavBarContainer from './nav_bar/nav_bar_container.jsx';
import DailyBudgetDisplayContainer from 
'./daily_budget_display/daily_budget_display_container.jsx';
import { AuthRoute, ProtectedRoute } from '../utils/route_util.js';
import IncomeItemForm from './budget_items/income_item_form.jsx';

const Root = ({ store }) => (
    <Provider store={ store }>
        <HashRouter>
            <div>
                <Route path='/' component={ NavBarContainer } />
                <ProtectedRoute exact path='/income' 
                    render={ () => <IncomeItemForm /> } />
                <ProtectedRoute path='/' 
                    render={ () => <DailyBudgetDisplayContainer /> } />
                <AuthRoute path='/signup' 
                    render={ () => <UserFormContainer formType="signup" /> } />
                <AuthRoute path='/login' 
                    render={ () => <UserFormContainer formType="login" /> } />
            </div>
        </HashRouter>
    </Provider>
);

export default Root;
