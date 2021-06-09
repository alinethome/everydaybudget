import { 
    selectNonRecurringItems,
    selectRecurringItems
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
