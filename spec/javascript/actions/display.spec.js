import { SET_ITEM_LIST_DISPLAY,
    setItemListDisplay } from 'frontend/actions/display.js';

describe('setItemListDisplay', () => {
    test('it produces an action of the SET_ITEM_LIST_DISPLAY type', () => {
        expect(setItemListDisplay("recurring").type)
            .toEqual(SET_ITEM_LIST_DISPLAY);
    })

    test('it produces an action with the recur type that was passed', () => {
        const recurType = "recurring";

        expect(setItemListDisplay("recurring").recurType)
            .toEqual(recurType);
    })
});
