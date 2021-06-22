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

        return (<div className="daily-budget-display">
            { this.state.formHidden ? "" : this.form() }
            <div className="daily-budget-display-info">
            <span className="daily-budget-display-remaining">
                $ { remaining?.toFixed(2) }
            </span>
            <span className="daily-budget-display-max">
                / { maxDaily?.toFixed(2) }
            </span>
            </div>
            <div className="daily-budget-display-buttons">
                <button onClick={ this.handlePlus }>+</button>
                <button onClick={ this.handleMinus }>&minus;</button>
            </div>
        </div>);
    }
}

export default DailyBudgetDisplay;
