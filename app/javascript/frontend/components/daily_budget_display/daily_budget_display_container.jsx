import { connect } from 'react-redux';
import { fetchBudget } from '../../actions/budget.js';
import { createNonRecurringItem } from '../../actions/non_recurring_items.js';
import DailyBudgetDisplay from './daily_budget_display.jsx';

const mapStateToProps = (state, ownProps) => ({
    budget: state.budget,
    maxDaily: state.budget.max_daily_budget,
    remaining: state.budget.remaining_daily_budget
});

const mapDispatchToProps = (dispatch, ownProps) => ({
    fetchBudget: () => dispatch(fetchBudget()),
    createNonRecurringItem: (item) => dispatch(createNonRecurringItem(item))
});

export default connect(mapStateToProps, mapDispatchToProps)(DailyBudgetDisplay);

