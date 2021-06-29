import { SET_ITEM_LIST_DISPLAY } from '../actions/display.js';

const displayReducer = (state = { itemList: "recurring" }, action) => {
    Object.freeze(state);

    switch(action.type) {
        case SET_ITEM_LIST_DISPLAY: 
            return { ...state, itemList: action.itemList };
        default: 
            return state;
    };

}

export default displayReducer;
