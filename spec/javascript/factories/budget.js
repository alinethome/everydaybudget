class Budget {
    constructor (attributes) {
        this.max_daily_budget = attributes.max_daily_budget || 50;
        this.remaining_daily_budget = attributes.remaining_daily_budget || 25;
    }
}

export default Budget;
