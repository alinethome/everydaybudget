import React from 'react';
import DailyBudgetForm from './daily_budget_form.jsx';

class DailyBudgetDisplay extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            title: '',
            amount: 0,
            currentType: 'expense',
            formHidden: true
        };

        this.handlePlus = this.handlePlus.bind(this);
        this.handleMinus = this.handleMinus.bind(this);
    }
    
    componentDidMount() {
        this.props.fetchBudget();
    }

    handlePlus() {
        if (this.state.formHidden || this.state.currentType === 'income') {
            this.toggleForm();
        }
        this.setState({ currentType: 'income' });
    }

    handleMinus() {
        if (this.state.formHidden || this.state.currentType === 'expense') {
            this.toggleForm();
        }

        this.setState({ currentType: 'expense' });
    }

    toggleForm() {
        let formHidden = this.state.formHidden ? false : true;
        this.setState({ formHidden })
    }

    form() {
        return(
            < DailyBudgetForm 
                key={ this.state.currentType }
                type={ this.state.currentType }
                createNonRecurringItem={ this.props.createNonRecurringItem }
                fetchBudget={ this.props.fetchBudget }
            />);
    }

    render() {
        const { maxDaily, remaining } = this.props;

        return (<div>
            <button onClick={ this.handlePlus }>+</button>
            { remaining } / { maxDaily }
            <button onClick={ this.handleMinus }>-</button>
            { this.state.formHidden ? "" : this.form() }
        </div>);
    }
}

export default DailyBudgetDisplay;
