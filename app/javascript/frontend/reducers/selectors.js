export const selectNonRecurringItems = (state) => {
    return Object.values(state.entities.nonRecurringItems)
        .sort((first, second) => {
            return first.date > second.date ? -1 : 1
    });
}

export const selectRecurringItems = (state) => {
    return Object.values(state.entities.recurringItems)
        .sort((first, second) => {
            if (first.end_date && second.end_date) {
                return first.end_date > second.end_date ? -1 : 1;
            } else if (first.end_date) {
                return 1;
            } else if (second.end_date) {
                return -1;
            } else {
                if (first.name.toLowerCase() < second.name.toLowerCase()) {
                    return -1;
                } else {
                    return 1;
                }
            }
    })
}

export const selectRecurringItemsOfType = (state, type) => {
    return selectRecurringItems(state).filter(item => item.type === type );
};

export const selectNonRecurringItemsOfType = (state, type) => {
    return selectNonRecurringItems(state).filter(item => item.type === type );
};

const hasMonthlyInstances = (item) => item.month_instances.length > 0;

const addInstances = (item, instancesByDay) => {
    item.month_instances.forEach((day) => {
        if (instancesByDay.hasOwnProperty(day)) {
            instancesByDay[day].push(item);
        } else {
            instancesByDay[day] = [item];
        }
    });

    return instancesByDay;
};

export const selectRecurringMonthlyItemsByDay = (state) => {
    let recurringThisMonth = {};

    selectRecurringItems(state).forEach((item) => {
        if (hasMonthlyInstances(item)) {
            addInstances(item, recurringThisMonth);
        }
    });

    return recurringThisMonth;
};

export const selectNonRecurringMonthlyItemsByDay = (state) => {
    let incurredThisMonth = {};

    selectNonRecurringItems(state).forEach((item) => {
        if (hasMonthlyInstances(item)) {
            addInstances(item, incurredThisMonth);
        }
    });

    return incurredThisMonth;
};
