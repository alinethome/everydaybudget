import { connect } from 'react-redux';
import { createNewUser } from '../../actions/session.js';
import UserForm from './user_form.jsx';

const mapDispatchToProps = (dispatch) => ({
    userAction: (formUser) => dispatch(createNewUser(formUser))
});

export default connect(null, mapDispatchToProps)(UserForm);
