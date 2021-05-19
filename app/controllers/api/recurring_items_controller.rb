class Api::RecurringItemsController < ApplicationController
  before_action :ensure_signed_in!
  before_action :ensure_owner_signed_in!, except: [:create]

  def create
    @item = RecurringItem.new(recurring_item_params)
    @item.user_id = params[:user_id]

    if @item.save
      render :show
    else
      render json: @item.errors.full_messages, status: 422
    end
  end

  def index
    @items = RecurringItem.where(user_id: params[:user_id].to_i)

    render :index
  end

  def update
    @item = selected_item

    if @item.update(recurring_item_params)
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

  private 

  def recurring_item_params
    params.require(:recurring_item).
      permit([:name, :type, :start_date, :end_date, 
              :recur_period, :recur_unit_type, :amount])
  end

  def selected_item
    RecurringItem.find_by(id: params[:id])
  end

  def ensure_owner_signed_in!
    if selected_item
      owner = selected_item.user_id 
    else
      owner = params[:user_id].to_i
    end

    unless owner == current_user.id
      render json: ['You do not have permission to do that'], 
      status: 403 
    end
  end
end
