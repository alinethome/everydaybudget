import React from 'react';

class Item extends React.Component {
    constructor(props) {
        super(props);
        this.handleStop = this.handleStop.bind(this);
        this.handleDelete = this.handleDelete.bind(this);
    }

    static date(dateString) {
        const date = new Date(dateString);
        const formattedDate = new Intl.DateTimeFormat('en-US')
            .format(date);
        return `${formattedDate}`;
    }

    handleStop() {
        const end_date = new Date()
        const item = { ...this.props.item, end_date };

        this.props.updateFn(item);
    }

    handleDelete() {
        this.props.destroyFn(this.props.item);
    }

    dateInfo() {
        const { item } = this.props;

        return (<span>
            { item.date ? Item.date(item.date) : ""  }
            { item.start_date ? Item.date(item.start_date) : ""  }
            { item.end_date ? ` - ${Item.date(item.end_date)}` : "" }
        </span>);
    }

    recurrenceInfo() {
        const { item } = this.props;
        const recurUnit = item.recur_unit_type === "MonthsUnitType" ?
            "months" : "days";

        return item.start_date ?   
            ( <p>every { item.recur_period } { recurUnit }</p>) :
            null;

    }

    render() {
        const { item } = this.props;

        return (
        <li>
            <p>{ item.name }: ${item.amount} | { this.dateInfo() }
            </p>
            { this.recurrenceInfo() }
            { item.start_date && item.end_date === null ? 
                <button onClick={ this.handleStop }>Stop</button> :
                    "" }
            <button onClick={ this.handleDelete }>Delete</button> 
        </li>
        );
    }
}

export default Item;
