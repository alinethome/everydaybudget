import React from 'react';
import Item from './item.jsx';

class ItemList extends React.Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {
        this.props.fetchRecurringItems();
        this.props.fetchNonRecurringItems();
    }

    render() {
        const { 
            recurringItems, 
            nonRecurringItems, 
            updateRecurringItem,
            destroyRecurringItem,
            destroyNonRecurringItem,
            updateNonRecurringItem
        } = this.props;

        return (
            <div>
                <h2>Recurring</h2>
                <ul>
                    { 
                        recurringItems.map((item) => {
                            return(<Item key={ item.id } 
                                item={ item }
                                recurring={ true }
                                destroyFn={ destroyRecurringItem }
                                updateFn={ updateRecurringItem }/>);
                        })
                    }
                </ul>
                <h2>Non-Recurring</h2>
                <ul>
                    { 
                        nonRecurringItems.map((item) => {
                            return(<Item key={ item.id } 
                                item={ item }
                                recurring={ false }
                                destroyFn={ destroyNonRecurringItem }
                                updateFn={ updateNonRecurringItem }/>);
                        })
                    }
                </ul>
            </div>);

    };
}; 
export default ItemList;
