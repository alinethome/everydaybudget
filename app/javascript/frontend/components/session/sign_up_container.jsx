import { connect } from 'react-redux';
import { createNewUser } from '../../actions/session.js';
import SignUp from './sign_up.jsx';

const mapDispatchToProps = (dispatch) => ({
    createNewUser: (formUser) => dispatch(createNewUser(formUser))
});

export default connect(null, mapDispatchToProps)(SignUp);
