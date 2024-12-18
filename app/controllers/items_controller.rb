class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: 'Item was successfully destroyed.'
    else
      flash[:alert] = 'Item could not be destroyed.'
      redirect_to items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_owner
    unless current_user == @item.user
      redirect_to root_path, alert: "You are not authorized to edit this item."
    end
  end

  def redirect_if_sold_out
    if @item.order.present?
      redirect_to root_path, alert: "売却済みの商品は編集できません。"
    end
  end
end
