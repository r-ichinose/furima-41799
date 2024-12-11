class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params) # フォームオブジェクトにパラメータを渡す
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
    params.require(:order_form).permit(:card_number, :expiration_date, :cvc).merge(user_id: current_user.id, item_id: @item.id)
  end
end
