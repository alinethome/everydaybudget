import React from 'react';
import Item from './item.jsx';

class ItemList extends React.Component {
    constructor(props) {
        super(props);
        this.state = { recurDisplay: "recurring" };

        this.handleClick = this.handleClick.bind(this);
    }

    componentDidMount() {
        this.props.fetchRecurringItems();
        this.props.fetchNonRecurringItems();
    }

    handleClick(recurDisplay) {
        return (e) => { 
            e.preventDefault();
            this.setState({ recurDisplay })
        };
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
            <div className="item-list">
                <ul className="item-list-type-menu">
                    <a href="#" 
                        className={this.state.recurDisplay == "recurring" ? 
                                "item-list-type-menu-selected" : ""}
                        onClick={ this.handleClick("recurring") }>
                        Recurring</a>
                    <a href="#" 
                        className={this.state.recurDisplay == "non-recurring" ? 
                                "item-list-type-menu-selected" : ""}
                        onClick={ this.handleClick("non-recurring") }>
                        Non-Recurring</a>
                </ul>

                { this.state.recurDisplay === "recurring" ? 

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
