import React from 'react';
import DayAndItem from './day_and_item.jsx';

class MonthlyBudget extends React.Component {
    constructor(props) {
        super(props)
    }

    componentDidMount() {
        this.props.fetchRecurringItems();
        this.props.fetchNonRecurringItems();
    }

    addItemsToDay(day, items, array){
        if (items[day]) {
            items[day].forEach((item) => {
                array.push([day, item]); });
        }

        return null;
    }

    buildDaysArray (recurringByDay, nonRecurringByDay){
        const array = [];

        for (let i = 1; i <= 31; i++)  {
            this.addItemsToDay(i, recurringByDay, array);
            this.addItemsToDay(i, nonRecurringByDay, array);
        }

        return array;
    };

    render() {
        const { recurringByDay, nonRecurringByDay } = this.props;
        const daysArray = this.buildDaysArray(recurringByDay, 
            nonRecurringByDay);

        return (
            <ul>
                {
                    daysArray.map((dayItemPair, index) => (
                        <DayAndItem key={`${index}-${dayItemPair[1].id}`}
                            dayItemPair={dayItemPair} />
                    ))
                }

            </ul>
        );
    };

}

export default MonthlyBudget;
