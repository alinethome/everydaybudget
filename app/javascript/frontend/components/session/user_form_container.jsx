import { connect } from 'react-redux';
import { login, createNewUser } from '../../actions/session.js';
import { receiveErrors } from '../../actions/errors.js';
import UserForm from './user_form.jsx';

const mapStateToProps = (state, ownProps) => ({
    formTitle: ownProps.formType === "login" ?
    "Log In" :
    "Sign Up",
    buttonText: ownProps.formType === "login" ? 
    "Log In!" :
    "Sign Up!",
    errors: state.errors
});

const mapDispatchToProps = (dispatch, ownProps) => ({
    userAction: (formUser) => {
        if (ownProps.formType === "login") {
            return dispatch(login(formUser));
        } else {
            return dispatch(createNewUser(formUser));
        }
    }, 
    receiveErrors: (errors) => dispatch(receiveErrors(errors))
});

export default connect(mapStateToProps, mapDispatchToProps)(UserForm);



