import React from 'react';
import { Link } from 'react-router-dom';

const NavBar = ({ logout, currentUser }) => {
    let sessionTools;

    if (currentUser) {
       sessionTools = (<div>
           { currentUser.email }
           <button onClick={ logout }>Logout</button>
       </div>);
    } else {
        sessionTools = (<div>
            <Link to="/signup">Sign up</Link>
        </div>);
    }

    return sessionTools;
};

export default NavBar;
