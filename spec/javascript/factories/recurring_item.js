function RecurringItem(attributes) {
    this.id = attributes.id || 1;
    this.name = attributes.name || "a recurring item";
    this.type = attributes.type || "income";
    this.start_date = attributes.start_date || new Date();
    this.end_date = attributes.end_date;
    this.amount = attributes.amount || 1000;
    this.recur_period = attributes.recur_period || 1;
    this.recur_unit_type = attributes.recur_unit_type || "MonthsUnitItem";
    this.month_instances = attributes.month_instances || 
        [this.start_date.getDate()];
}

export default RecurringItem;
