import { connect } from 'react-redux';
import { 
    fetchRecurringItems, 
    updateRecurringItem,
    destroyRecurringItem
} from '../../actions/recurring_items.js';
import { 
    fetchNonRecurringItems,
    updateNonRecurringItem,
    destroyNonRecurringItem
} from '../../actions/non_recurring_items.js';
import { 
    selectRecurringItemsOfType, 
    selectNonRecurringItemsOfType 
} from '../../reducers/selectors.js'
import { setItemListDisplay } from '../../actions/display.js';
import ItemList from './item_list.jsx';

const mapStateToProps = (state, ownProps) => ({
    recurringItems: selectRecurringItemsOfType(state, ownProps.type),
    nonRecurringItems: selectNonRecurringItemsOfType(state, ownProps.type),
    itemListDisplay: state.display.itemList
});

const mapDispatchToProps = (dispatch) => ({
    fetchRecurringItems: () => dispatch(fetchRecurringItems()),
    fetchNonRecurringItems: () => dispatch(fetchNonRecurringItems()),
    updateRecurringItem: (item) => dispatch(updateRecurringItem(item)),
    updateNonRecurringItem: (item) => dispatch(updateNonRecurringItem(item)),
    destroyRecurringItem: (item) => dispatch(destroyRecurringItem(item)),
    destroyNonRecurringItem: (item) => dispatch(destroyNonRecurringItem(item)),
    setItemListDisplay: (recurType) => dispatch(setItemListDisplay(recurType))
});


export default connect(mapStateToProps, mapDispatchToProps)(ItemList);
