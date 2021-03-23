import React from 'react';

class SignUp extends React.Component {
    render() {
        return (
            <form>
                <h1>Sign Up for EverydayBudget</h1>
                <label>Email:
                    <input type="text" />
                </label>
                <label>Password:
                    <input type="password" />
                </label>
                <input type="submit" value="Sign up!"/>
            </form>
        );
    }
}

export default SignUp;
