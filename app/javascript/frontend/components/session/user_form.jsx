import React from 'react';

class UserForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            email: '',
            password: ''
        };

        this.handleSubmit = this.handleSubmit.bind(this);
        this.renderErrors = this.renderErrors.bind(this);
    }

    componentDidMount() {
        this.clearErrors();
    }

    handleInput(type) {
        return (e) => {
            this.setState({ [type]: e.target.value });
        };
    }

    handleSubmit(e) {
        e.preventDefault();
        this.props.userAction(this.state)
            .then(() => { 
                this.props.history.push('/');
                this.clearErrors();
            }, this.renderErrors);
    }

    getToken() {
        return document.elementsByName('csrf-token')[0].content;
    }

    clearErrors() {
        this.props.receiveErrors([]);
    }

    renderErrors(response) {
        this.props.receiveErrors(response.responseJSON);
    }

    render() {
        return (
            <div className="user-form">
                <h2>{ this.props.formTitle }</h2>
                <form>
                    <ul className="user-form-errors">
                        { this.props.errors.map((error, index) => (
                        <li key={index}>{error} </li>
                        ))}
                    </ul>

                    <label for="user-form-email">Email:</label>
                        <input id="user-form-email" type="text" 
                            value={ this.state.email }
                            onChange={ this.handleInput('email') }/>
                    <label for="user-form-password">Password:</label>
                        <input id="user-form-password" type="password"
                            value={ this.state.password }
                            onChange={ this.handleInput('password') }/>
                    <button
                        onClick={ this.handleSubmit } >
                        { this.props.buttonText }
                    </button>
                </form>
            </div>
        );
    }
}

export default UserForm;
