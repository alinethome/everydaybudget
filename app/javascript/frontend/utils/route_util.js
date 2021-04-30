import React from 'react';
import { connect } from 'react-redux';
import { Redirect, Route, withRouter } from 'react-router-dom';

const mapStateToProps = (state) => ({
    loggedIn: Boolean(state.session.current_user)
});

const Auth = ({ loggedIn, path, render }) => (
    <Route 
        path={path}
        render={(props) => (
            loggedIn ? (<Redirect to="/" />) : render(props)
        )}
    />
);

const Protected = ({ loggedIn, path, render }) => (
    <Route 
        path={path}
        render={(props) => (
            !loggedIn ? (<Redirect to="/login" />) : render(props)
        )}
    />
);

export const AuthRoute = withRouter(connect(mapStateToProps)(Auth));
export const ProtectedRoute = withRouter(connect(mapStateToProps)(Protected));
