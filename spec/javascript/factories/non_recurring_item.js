class NonRecurringItem {
    constructor(attributes) {
        this.id = attributes.id || 1;
        this.name = attributes.name || "a recurring item";
        this.type = attributes.type || "expense";
        this.date = attributes.start_date || new Date();
        this.amount = attributes.amount || 50;
        this.month_instances = attributes.month_instances || 
            [this.date.getDate()];
    }
}

export default NonRecurringItem;
