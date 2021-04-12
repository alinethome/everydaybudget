import { connect } from 'react-redux';
import { login } from '../../actions/session.js';
import UserForm from './user_form.jsx';

const mapDispatchToProps = (dispatch) => ({
    userAction: (formUser) => dispatch(login(formUser))
});

export default connect(null, mapDispatchToProps)(UserForm);


