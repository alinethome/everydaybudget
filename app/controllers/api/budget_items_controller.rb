class Api::BudgetItemsController < ApplicationController
  before_action :ensure_signed_in!
  before_action :ensure_owner_signed_in!, except: [:create, :index]

  def create
  end

  def show
  end

  def index
  end

  def update
  end

  def destroy
  end

  private 

  def ensure_owner_signed_in!
    begin  
      owner = selected_item.user_id 
    rescue NoMethodError
      owner = nil 
    end

    unless owner == current_user.id
      render json: ['You do not have permission to do that'], 
      status: 403 
    end
  end
end
