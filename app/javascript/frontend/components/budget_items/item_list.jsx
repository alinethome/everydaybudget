import React from 'react';
import Item from './item.jsx';

class ItemList extends React.Component {
    constructor(props) {
        super(props);
        this.handleClick = this.handleClick.bind(this);
    }

    componentDidMount() {
        this.props.fetchRecurringItems();
        this.props.fetchNonRecurringItems();
        this.props.setItemListDisplay('non-recurring');
    }

    handleClick(recurDisplay) {
        return (e) => { 
            e.preventDefault();
            this.props.setItemListDisplay(recurDisplay);
        };
    }

    render() {
        const { 
            recurringItems, 
            nonRecurringItems, 
            updateRecurringItem,
            destroyRecurringItem,
            destroyNonRecurringItem,
            updateNonRecurringItem,
            itemListDisplay
        } = this.props;

        return (
            <div className="item-list">
                <ul className="item-list-type-menu">
                    <a href="#" 
                        className={ itemListDisplay === "recurring" ? 
                                "item-list-type-menu-selected" : ""}
                        onClick={ this.handleClick("recurring") }>
                        Recurring</a>
                    <a href="#" 
                        className={ itemListDisplay ===
                                "non-recurring" ? 
                                "item-list-type-menu-selected" : ""}
                        onClick={ this.handleClick("non-recurring") }>
                        Non-Recurring</a>
                </ul>

                { itemListDisplay === "recurring" ? 

                    <ul className="item-list-items">
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
                    :
                    <ul className="item-list-items">
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
                }
            </div>);

    };
}; 
export default ItemList;
