import React from 'react';

class UserForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            email: '',
            password: ''
        };

        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleInput(type) {
        return (e) => {
            this.setState({ [type]: e.target.value });
        };
    }

    handleSubmit(e) {
        e.preventDefault();
        this.props.userAction(this.state)
            .then(() => this.props.history.push('/'), 
            (error) => console.log(error));
    }

    getToken() {
        return document.elementsByName('csrf-token')[0].content;
    }

    render() {
        return (
            <form>
                <h1>Sign Up for EverydayBudget</h1>
                <label>Email:
                    <input type="text" 
                        value={ this.state.email }
                        onChange={ this.handleInput('email') }/>
                </label>
                <label>Password:
                    <input type="password"
                        value={ this.state.password }
                        onChange={ this.handleInput('password') }/>
                </label>
                <input type="submit" 
                    value="Sign up!"
                    onClick={ this.handleSubmit } />
            </form>
        );
    }
}

export default UserForm;
