class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  
  def index
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    if @order.save
      redirect_to root_path, notice: '購入が完了しました'
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :city, :address, :building, :phone_number, :token).merge(user_id: current_user.id, item_id: @item.id)
  end
end