import { connect } from 'react-redux';
import MonthlyBudget from './monthly_budget.jsx';
import { fetchRecurringItems } from '../../actions/recurring_items.js'
import { fetchNonRecurringItems } from '../../actions/non_recurring_items.js'
import {
    selectRecurringMonthlyItemsByDay,
    selectNonRecurringMonthlyItemsByDay
} from '../../reducers/selectors.js';

const mapStateToProps = (state) => ({
    recurringByDay: selectRecurringMonthlyItemsByDay(state),
    nonRecurringByDay: selectNonRecurringMonthlyItemsByDay(state)
});

const mapDispatchToProps = (dispatch) => ({
    fetchRecurringItems: () => dispatch(fetchRecurringItems()),
    fetchNonRecurringItems: () => dispatch(fetchNonRecurringItems()),
});

export default connect(mapStateToProps, mapDispatchToProps)(MonthlyBudget);
