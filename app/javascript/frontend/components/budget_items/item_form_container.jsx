import { connect } from 'react-redux';
import { createRecurringItem } from '../../actions/recurring_items.js';
import { createNonRecurringItem } from '../../actions/non_recurring_items.js';
import ItemForm from './item_form.jsx';

const mapDispatchToProps = (dispatch) => ({
    createNonRecurringItem: (item) => dispatch(createNonRecurringItem(item)),
    createRecurringItem: (item) => dispatch(createRecurringItem(item))
});

const mergeProps = (stateProps, dispatchProps, ownProps) => {
    let defaultTitle = ownProps.type === 'expense' ? 
        "some expense" :
        "some income item";

    return {
        ...ownProps,
        ...stateProps,
        ...dispatchProps,
        defaultTitle
    };
};

export default connect(null, mapDispatchToProps, mergeProps)(ItemForm);
