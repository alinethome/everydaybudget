import React from 'react';

const DayAndItem = ({ dayItemPair }) => {
    const day = dayItemPair[0];
    const item = dayItemPair[1];
    const sign = item.type === "income" ? "+" : "-";

    return (
        <li className="monthly-budget-item">
            <span className="monthly-budget-item-day">{day}:</span>
            <span className="monthly-budget-item-name">{item.name}</span>
            <span className={`monthly-budget-item-amount 
                monthly-budget-item-amount-${item.type}`}>
                ({sign}${item.amount})
            </span>
        </li>
    )};

export default DayAndItem;
