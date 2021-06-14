import React from 'react';
import { Link } from 'react-router-dom';

const NavBar = ({ logout, currentUser }) => {
    let sessionTools, navigation;

    if (currentUser) {
        navigation = (<ul>
            <Link to="/">My Budget</Link>
            <Link to="/income">Manage Income</Link>
            <Link to="/expenses">Manage Expenses</Link>
        </ul>);

    } else {
        navigation = null;
    }

    if (currentUser) {
        sessionTools = (<div>
            { currentUser.email }
            <button onClick={ logout }>Logout</button>
        </div>);
    } else {
        sessionTools = (<div>
            <Link to="/signup">Sign up</Link>
            <Link to="/login">Log in</Link>
        </div>);
    }

    return (<nav> 
        { navigation } { sessionTools } 
    </nav>);
};

export default NavBar;
