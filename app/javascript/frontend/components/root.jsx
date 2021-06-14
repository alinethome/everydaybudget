import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import UserFormContainer from './session/user_form_container.jsx';
import NavBarContainer from './nav_bar/nav_bar_container.jsx';
import DailyBudgetDisplayContainer from 
'./daily_budget_display/daily_budget_display_container.jsx';
import { AuthRoute, ProtectedRoute } from '../utils/route_util.js';
import ItemFormContainer from './budget_items/item_form_container.jsx';
import ItemListContainer from './budget_items/item_list_container.jsx';
import MonthlyBudgetContainer from 
'./monthly_budget/monthly_budget_container.jsx';

const Root = ({ store }) => (
    <Provider store={ store }>
        <HashRouter>
            <div>
                <Route path='/' component={ NavBarContainer } />
                <ProtectedRoute path='/income' 
                    render={ () => <ItemFormContainer type="income" /> } />
                <ProtectedRoute path='/income'
                    render={ () => <ItemListContainer type="income"/>} />
                <ProtectedRoute path='/expenses' 
                    render={ () => <ItemFormContainer type="expense" /> } />
                <ProtectedRoute path='/expenses'
                    render={ () => <ItemListContainer type="expense"/>} />
                <ProtectedRoute path='/' exact
                    render={ () => <DailyBudgetDisplayContainer /> } />
                <ProtectedRoute path='/monthly'
                    render={ () => <MonthlyBudgetContainer />} />
                <AuthRoute path='/signup' 
                    render={ () => <UserFormContainer formType="signup" /> } />
                <AuthRoute path='/login' 
                    render={ () => <UserFormContainer formType="login" /> } />
            </div>
        </HashRouter>
    </Provider>
);

export default Root;
