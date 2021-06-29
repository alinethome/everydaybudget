import React from 'react';

class ItemForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            title: this.props.defaultTitle,
            amount: 0,
            type: "non-recurring",
            period: 0,
            unit: "DaysUnitItem"
        };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
        this.clearForm = this.clearForm.bind(this);
    }

    handleChange(field) {
        return (e) => {
            this.setState({ [field]: e.target.value });
        };

    }

    handleSubmit(e) {
        e.preventDefault();
        if (this.state.type === 'recurring') {
            this.submitRecurring();
        } else {
            this.submitNonRecurring();
        }
    }

    submitRecurring() {
        let item = {
            name: this.state.title,
            type: this.props.type,
            start_date: new Date(),
            end_date: null,
            amount: this.state.amount,
            recur_period: this.state.period,
            recur_unit_type: this.state.unit
        };

        this.props.createRecurringItem(item)
            .then(this.clearForm)
            .then(this.props.setItemListDisplay("recurring"));
    }

    submitNonRecurring() {
        let item = {
            name: this.state.title,
            type: this.props.type,
            date: new Date(),
            amount: this.state.amount,
        };

        this.props.createNonRecurringItem(item)
            .then(this.clearForm)
            .then(this.props.setItemListDisplay("non-recurring"));
    }

    clearForm() {
        this.setState({
            title: this.props.defaultTitle,
            amount: 0,
            type: "non-recurring",
            period: 0,
            unit: "DaysUnitItem"
        });
    }

    recurForm() {
        return (
            <div>
                <input type="text" 
                    className="item-form-number-field"
                    onChange={ this.handleChange("period")}
                    value={ this.state.period }/>
                <select name="unit" 
                    value={ this.state.unit }
                    onChange={ this.handleChange("unit")}>
                    <option value="DaysUnitItem">days</option>
                    <option value="MonthsUnitItem">months</option>
                </select>
            </div>
        );
    }

    render() {
        return (
            <form className="item-form">
                <input type="text"
                    className="item-form-text-field"
                    onChange={ this.handleChange("title")}
                    value={ this.state.title }/>
                <input type="text"
                    className="item-form-number-field"
                    onChange={ this.handleChange("amount")}
                    value={ this.state.amount }/>
                $
                <select name="type" 
                    value={ this.state.type }
                    onChange={ this.handleChange("type") }>
                    <option value="non-recurring">once</option>
                    <option value="recurring">every</option>
                </select>
                { this.state.type === "recurring" ? this.recurForm() : null }
                <button onClick={ this.handleSubmit }>Add</button>
            </form>
        );

    }

}

export default ItemForm;

