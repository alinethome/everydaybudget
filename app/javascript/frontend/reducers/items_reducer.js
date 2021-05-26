const itemsReducer = ({ 
    receiveSingle, 
    receiveMultiple, 
    deleteSingle 
}) => {
    return (state = {}, action) => {
        Object.freeze(state);

        switch(action.type) {
            case receiveMultiple:
                return stateFromMultiple(action);

            case receiveSingle:
                return stateFromSingle(state, action);

            case deleteSingle:
                return stateFromDeletion(state, action);

            default: 
                return state;
        };
    };
};

const stateFromMultiple = (action) => {
    return action.items
        .reduce((state, item) => { 
            state[item.id] = item;
            return state;
        }, {});
};

const stateFromSingle = (state, action) => {
    return { ...state, [action.item.id]: action.item };
};

const stateFromDeletion = (state, action) => {
    let newState = { ...state };
    delete newState[action.item.id];
    return newState;
};

export default itemsReducer;
