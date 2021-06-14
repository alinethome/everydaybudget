import React from 'react';

const DayAndItem = ({ dayItemPair }) => {
    const day = dayItemPair[0];
    const item = dayItemPair[1];
    const sign = item.typpe === "income" ? "+" : "-";

    return (
        <li>
            {day}: {item.name} ({sign}${item.amount})
        </li>
    )};

export default DayAndItem;
