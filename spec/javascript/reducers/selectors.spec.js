import { 
    selectNonRecurringItems,
    selectRecurringItems,
    selectNonRecurringItemsOfType,
    selectRecurringItemsOfType,
    selectRecurringMonthlyItemsByDay,
    selectNonRecurringMonthlyItemsByDay
} from 'frontend/reducers/selectors.js';
import NonRecurringItem from '../factories/non_recurring_item.js';
import RecurringItem from '../factories/recurring_item.js';


describe('selectNonRecurringItems', () => {
    describe('given a state with no non-recurring items', () => {
        const state = { entities: { nonRecurringItems: {} }};

        test('it returns an empty array', () => {
            expect(selectNonRecurringItems(state)).toEqual([]);
        });
    });

    describe('given a state with nonRecurringItems', () => {
        const first = new NonRecurringItem({ id: 1, 
            date: new Date(2021, 5, 3)});
        const second = new NonRecurringItem({ id: 2, 
            date: new Date(2021, 5, 1)});
        const third = new NonRecurringItem({ id: 3, 
            date: new Date(2021, 1, 1)});

        const state = { entities: { nonRecurringItems: {
            [second.id]: second, 
            [first.id]: first, 
            [third.id]: third
        }}};

        test('it returns an array with all of them', () => {
            expect(selectNonRecurringItems(state)).toContain(first);
            expect(selectNonRecurringItems(state)).toContain(second);
            expect(selectNonRecurringItems(state)).toContain(third);
        })

        test('it sorts them by date, with the newest first', () => {
            expect(selectNonRecurringItems(state))
                .toEqual([first, second, third]);
        });

    })
});

describe('selectRecurringItems', () => {
    describe('given a state with no recurring items', () => {
        const state = { entities: { recurringItems: {} }};

        test('it returns an empty array', () => {
            expect(selectRecurringItems(state)).toEqual([]);
        });
    });

    describe('given a recurring items', () => {
        const noEndDateFirst = new RecurringItem({ 
            id: 4, 
            name: "a"
        });

        const noEndDateSecond = new RecurringItem({ 
            id: 1, 
            name: "b"
        });

        const noEndDateThirdLower = new RecurringItem({
            id: 2, 
            name: "C"
        });

        const earlyEndDate = new RecurringItem({
            id: 7, 
            start_date: new Date(2019, 7, 10),
            end_date: new Date(2020, 4, 7)
        });

        const lateEndDate = new RecurringItem({
            id: 6, 
            start_date: new Date(2019, 7, 10),
            end_date: new Date(2020, 5, 7)
        });

        const state = { entities: { recurringItems: {
            [lateEndDate.id]: lateEndDate,
            [noEndDateSecond.id]: noEndDateSecond,
            [earlyEndDate.id]: earlyEndDate,
            [noEndDateThirdLower.id]: noEndDateThirdLower,
            [noEndDateFirst.id]: noEndDateFirst
        }}};

        test('it returns an array with all recurring items', () => {
            expect(selectRecurringItems(state)).toContain(noEndDateFirst);
            expect(selectRecurringItems(state)).toContain(noEndDateSecond);
            expect(selectRecurringItems(state)).toContain(earlyEndDate);
            expect(selectRecurringItems(state)).toContain(lateEndDate);
        });

        test('it lists items with an end-date later', () => {
            const result = selectRecurringItems(state);

            expect(result.indexOf(lateEndDate))
                .toBeGreaterThan(result.indexOf(noEndDateSecond));
        });

        test('it lists items with end-dates most recent end-date first', () => {
            const result = selectRecurringItems(state);

            expect(result.indexOf(lateEndDate))
                .toBeLessThan(result.indexOf(earlyEndDate));
        });

        test('it doesn\'t care about case', () => {
            const result = selectRecurringItems(state);

            expect(result.indexOf(noEndDateSecond))
                .toBeLessThan(result.indexOf(noEndDateThirdLower));
        });
    })
});

describe('selectNonRecurringItemsOfType', () => {
    describe('given a state with no recurring items', () => {
        test('it returns an empty array', () => {
            const state = { entities: { nonRecurringItems: {} } };

            expect(selectNonRecurringItemsOfType(state, "income"))
                .toEqual([]);
            expect(selectNonRecurringItemsOfType(state, "expense"))
                .toEqual([]);

        });
    });

    describe('given a state with no items of the correct type', () => {
        const expense = new NonRecurringItem({
            id: 9,
            date: new Date(2020, 2, 17),
            type: "expense"
        });

        const incomeItem = new NonRecurringItem({
            id: 10,
            date: new Date(2020, 2, 17),
            type: "income"
        });

        const stateWithNoExpenses = { entities: {
            nonRecurringItems: { incomeItem }
        }};

        const stateWithNoIncome = { entities: {
            nonRecurringItems: { expense }
        }};

        test('it return an empty array', () => {

            expect(selectNonRecurringItemsOfType(stateWithNoIncome, "income"))
                .toEqual([]);
            expect(selectNonRecurringItemsOfType(stateWithNoExpenses, 
                "expense")).toEqual([]);
        });
    })

    describe('given a state with multiple appropriate items', () => {
        const earlyDate = new NonRecurringItem({
            id: 7, 
            date: new Date(2020, 4, 7),
            type: "income"
        });

        const lateDate = new NonRecurringItem({
            id: 6, 
            date: new Date(2020, 5, 7),
            type: "income"
        });

        const state = { entities: { nonRecurringItems: {
            [earlyDate.id]: earlyDate,
            [lateDate.id]: lateDate
        }}};

        test('it preserves the correct order', () => {
            expect(selectNonRecurringItemsOfType(state, 'income'))
                .toEqual([lateDate, earlyDate]);
        });
    })
});


describe('selectRecurringItemsOfType', () => {
    describe('given a state with no recurring items', () => {
        test('it returns an empty array', () => {
            const state = { entities: { recurringItems: {} } };

            expect(selectRecurringItemsOfType(state, "income"))
                .toEqual([]);
            expect(selectRecurringItemsOfType(state, "expense"))
                .toEqual([]);

        });
    });

    describe('given a state with no items of the correct type', () => {
        const expense = new RecurringItem({
            id: 9,
            start_date: new Date(2020, 2, 17),
            type: "expense"
        });

        const incomeItem = new RecurringItem({
            id: 10,
            start_date: new Date(2020, 2, 17),
            type: "income"
        });

        const stateWithNoExpenses = { entities: {
            recurringItems: { incomeItem }
        }};

        const stateWithNoIncome = { entities: {
            recurringItems: { expense }
        }};

        test('it return an empty array', () => {

            expect(selectRecurringItemsOfType(stateWithNoIncome, "income"))
                .toEqual([]);
            expect(selectRecurringItemsOfType(stateWithNoExpenses, "expense"))
                .toEqual([]);
        });
    })

    describe('given a state with multiple appropriate items', () => {
        const noEndDateFirst = new RecurringItem({ 
            id: 4, 
            name: "a",
            type: "income"

        });

        const noEndDateSecond = new RecurringItem({ 
            id: 1, 
            name: "b",
            type: "income"
        });

        const noEndDateThirdLower = new RecurringItem({
            id: 2, 
            name: "C",
            type: "income"
        });

        const earlyEndDate = new RecurringItem({
            id: 7, 
            start_date: new Date(2019, 7, 10),
            end_date: new Date(2020, 4, 7),
            type: "income"
        });

        const lateEndDate = new RecurringItem({
            id: 6, 
            start_date: new Date(2019, 7, 10),
            end_date: new Date(2020, 5, 7),
            type: "income"
        });

        const state = { entities: { recurringItems: {
            [lateEndDate.id]: lateEndDate,
            [noEndDateSecond.id]: noEndDateSecond,
            [earlyEndDate.id]: earlyEndDate,
            [noEndDateThirdLower.id]: noEndDateThirdLower,
            [noEndDateFirst.id]: noEndDateFirst
        }}};

        test('it preserves the correct order', () => {
            expect(selectRecurringItemsOfType(state, 'income'))
                .toEqual([noEndDateFirst, noEndDateSecond,
                    noEndDateThirdLower, lateEndDate, earlyEndDate]);
        });
    });
});

describe('selectNonRecurringMonthlyItemsByDay', () => {
    describe('given a state with no non-recurring items', () => {
        const state = { entities: { nonRecurringItems: {} }};

        test('it returns an empty object', () => {
            expect(selectNonRecurringMonthlyItemsByDay(state))
                .toEqual({});
        });
    })

    describe('given a state with items from before that month', () => {
        const lastYearIncome = new NonRecurringItem({ 
            id: 4, 
            name: "a",
            type: "income",
            date: new Date(2020, 12, 31),
            month_instances: []
        });

        const lastMonthExpense = new NonRecurringItem({ 
            id: 1, 
            name: "b",
            type: "expense",
            date: new Date(2021, 5, 28),
            month_instances: []
        });

        const state = { entities: { nonRecurringItems: { 
            [lastMonthExpense.id]: lastMonthExpense, 
            [lastYearIncome.id]: lastYearIncome 
        }}};

        test('it returns an empty object', () => {
            expect(selectNonRecurringMonthlyItemsByDay(state))
                .toEqual({});
        });
    })

    describe('given a state with items from that month', () => {
        const day = 2;
        const income = new NonRecurringItem({
            month_instances: [day]
        });

        const state = { entities: { nonRecurringItems: {
            [income.id]: income
        }}};

        test('it returns an object with the day it was incurred as key', () => {
            expect(selectNonRecurringMonthlyItemsByDay(state)
                .hasOwnProperty(day)).toEqual(true);
        });

        test('the key for a day holds an array with that day\'s items', () => {
            expect(selectNonRecurringMonthlyItemsByDay(state)[day])
                .toEqual([income]);
        });

        describe('given a state with items incurred the same day', () => {
            const expense = new NonRecurringItem({
                id: income.id + 1, 
                month_instances: [day]
            });

            const stateWithRepeatDays = { entities: { nonRecurringItems: {
                [income.id]: income,
                [expense.id]: expense
            }}};

            test('items that recur on a day are in that day\'s array', () => {
                expect(selectNonRecurringMonthlyItemsByDay(stateWithRepeatDays)
                    [day]).toContain(income)
                expect(selectNonRecurringMonthlyItemsByDay(stateWithRepeatDays)
                    [day]).toContain(expense)
            });
        });
    });
})

describe('selectRecurringMonthlyItemsByDay', () => {
    describe('given a state with no recurring items', () => {
        const state = { entities: { recurringItems: {} }};

        test('it returns an empty object', () => {
            expect(selectRecurringMonthlyItemsByDay(state))
                .toEqual({});
        });
    })

    describe('given a state\' recurring items won\'t recur that month', () => {
        const endedTooEarly = new RecurringItem({ 
            id: 4, 
            name: "a",
            type: "income",
            start_date: new Date(2019, 2, 7),
            end_date: new Date(2020, 8, 2),
            month_instances: []
        });

        const bimonthlyExpense = new RecurringItem({ 
            id: 1, 
            name: "b",
            type: "expense",
            start_date: new Date(2021, 3, 28),
            month_instances: []
        });

        const state = { entities: { recurringItems: { 
            [endedTooEarly.id]: endedTooEarly, 
            [endedTooEarly.id]: bimonthlyExpense 
        }}};

        test('it returns an empty object', () => {
            expect(selectRecurringMonthlyItemsByDay(state))
                .toEqual({});
        });
    })

    describe('given a state with recrring items that recur that month', () => {
        const day1 = 2;
        const day2 = 17;
        const recurringIncome = new RecurringItem({
            month_instances: [day1, day2]
        });

        const state = { entities: { recurringItems: {
            [recurringIncome.id]: recurringIncome
        }}};

        test('it returns an object with keys for the days it recurs', () => {
            expect(selectRecurringMonthlyItemsByDay(state)
                .hasOwnProperty(day1)).toEqual(true);

            expect(selectRecurringMonthlyItemsByDay(state)
                .hasOwnProperty(day2)).toEqual(true);
        });

        test('the key for a day holds an array with that day\'s items', () => {
            expect(selectRecurringMonthlyItemsByDay(state)[day1])
                .toEqual([recurringIncome]);
        });

        describe('given a state with items that recur the same day', () => {
            const recurringExpense = new RecurringItem({
                id: recurringIncome.id + 1, 
                month_instances: [day1]
            });

            const stateWithRepeatDays = { entities: { recurringItems: {
                [recurringIncome.id]: recurringIncome,
                [recurringExpense.id]: recurringExpense
            }}};

            test('items that recur on a day are in that day\'s array', () => {
                expect(selectRecurringMonthlyItemsByDay(stateWithRepeatDays)
                    [day1]).toContain(recurringIncome)
                expect(selectRecurringMonthlyItemsByDay(stateWithRepeatDays)
                    [day1]).toContain(recurringExpense)
            });
        });
    });
});

