import { RECEIVE_BUDGET } from '../actions/budget.js';

const budgetReducer = (state = {}, action) => {
    Object.freeze(state);

    switch(action.type) {
        case RECEIVE_BUDGET:
            return action.budget;
        default:
            return state;
    };
};

export default budgetReducer;
