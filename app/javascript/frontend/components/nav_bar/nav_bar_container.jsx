import React from 'react';
import { connect } from 'react-redux';
import NavBar from './nav_bar.jsx';
import { logout } from '../../actions/session.js';

const mapStateToProps  = (state) => ({
    currentUser: state.session.current_user
});

const mapDispatchToProps = (dispatch) => ({
    logout: () => dispatch(logout)
});

export default connect(mapStateToProps, mapDispatchToProps)(NavBar);

