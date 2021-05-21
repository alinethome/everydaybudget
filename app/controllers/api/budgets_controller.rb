class Api::BudgetsController < ApplicationController
  before_action :ensure_signed_in! 

  def show
    recurring_items = current_user.recurring_items
    non_recurring_items = current_user.non_recurring_items

    @budget = Budget.new(recurring_items: recurring_items,
                        non_recurring_items: non_recurring_items)
  end
end
