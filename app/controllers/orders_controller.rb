class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_invalid_access, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = OrderForm.new
  end

  def create
    @order = OrderForm.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_access
    if @item.sold_out? || current_user == @item.user
      redirect_to root_path, alert: "この商品は購入できません。"
    end
  end

  def order_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end