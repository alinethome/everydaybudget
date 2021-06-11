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
            <div>
                <ul>
                    <a href="#" onClick={ this.handleClick("recurring") }>
                        Recurring</a>
                    <a href="#" onClick={ this.handleClick("non-recurring") }>
                        Non-Recurring</a>
                </ul>

                { this.state.recurDisplay === "recurring" ? 

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
                    :
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
                }
            </div>);

    };
}; 
export default ItemList;
