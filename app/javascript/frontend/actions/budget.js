import { getBudget } from '../utils/budget/api_util.js';

export const RECEIVE_BUDGET = "RECEIVE_BUDGET";

const receiveBudget = (budget) => ({
    type: RECEIVE_BUDGET,
    budget
});

export const fetchBudget = () => (dispatch) => {
    return getBudget()
        .then((budget) => dispatch(receiveBudget(budget)));
};
