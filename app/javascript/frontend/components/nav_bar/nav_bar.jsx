import React from 'react';

const NavBar = ({ logout, currentUser }) => {
    let sessionTools;

    if (currentUser) {
       sessionTools = (<div>
           { currentUser.email }
           <button onClick={ logout }>Logout</button>
       </div>);
    }

    return sessionTools;
};

export default NavBar;
