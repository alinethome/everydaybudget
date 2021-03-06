class Api::NonRecurringItemsController < Api::BudgetItemsController
  def create
    @item = NonRecurringItem.new(non_recurring_item_params)
    @item.user_id = current_user.id

    if @item.save
      render :show
    else
      render json: @item.errors.full_messages, status: 422
    end
  end

  def update
    @item = selected_item

    if @item.update(non_recurring_item_params)
      render :show
    else
      render json: @item.errors.full_messages, status: 400
    end
  end
  
  def destroy
    @item = selected_item

    if @item
      @item.destroy
      render :show
    else
      render json: ['The item could not be found']
    end
  end

  def show
    @item = selected_item

    render :show
  end

  def index
    @items = NonRecurringItem.where(user_id: current_user.id)

    render :index
  end

  private
  
  def selected_item
    NonRecurringItem.find_by(id: params[:id])
  end

  def non_recurring_item_params
    params.require(:item).
      permit([:name, :type, :date, :amount])
  end
end
