import React from 'react';

class DailyBudgetForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = { 
            amount: 0,
            title: this.defaultTitle(),
        };

        this.handleInput = this.handleInput.bind(this);
        this.handleAdd = this.handleAdd.bind(this);
        this.clearForm = this.clearForm.bind(this);
    }

    defaultTitle() {
        return this.props.type === 'expense' ? 
            'some one-time expense' :
            'some one-time income';
    }

    handleInput(field) {
        return (e) => { 
            this.setState({ [field]: e.target.value });
        }
    }

    handleAdd() {
        let item = {
            name: this.state.title,
            type: this.props.type,
            date: new Date(),
            amount: this.state.amount
        };

        this.props.createNonRecurringItem(item)
            .then(this.props.fetchBudget)
            .then(this.clearForm)
            .then(this.hideForm)
    }

    clearForm() {
        this.setState({ 
            amount: 0,
            title: this.defaultTitle()
        });
    }

    form() {
        return (
            <form>
                <input type="text"
                    value={ this.state.title }
                    onChange={ this.handleInput('title') }
                /> 
                <input type="text"
                    value={ this.state.amount }
                    onChange={ this.handleInput('amount') }
                /> $
                <button onClick={ this.handleAdd } >
                    Add
                </button>
            </form>
        );
    }

    render() {
        return this.state.hidden ? null : this.form();
    }
}

export default DailyBudgetForm;
