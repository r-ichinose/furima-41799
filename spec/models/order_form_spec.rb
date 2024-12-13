require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = OrderForm.new(
      user_id: 1, 
      item_id: 1,
      post_code: '123-4567',
      prefecture_id: 1,
      city: 'Tokyo',
      address: 'Shibuya 1-1-1',
      building: 'LA Building',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  describe 'OrderFormのバリデーション' do
    context '正常系' do
      it '全ての情報が正しく入力されていれば有効である' do
        expect(@order_form).to be_valid
      end

      it 'buildingが空でも有効である' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end

      it 'phone_numberが10桁でも有効である' do
        @order_form.phone_number = '0901234567'
        expect(@order_form).to be_valid
      end
    end

    context '異常系' do
      it 'user_idが空だと無効である' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと無効である' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'post_codeが空だと無効である' do
        @order_form.post_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Post code can't be blank")
      end

      it 'prefecture_idが空だと無効である' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが0だと無効である' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'post_codeが不正な形式だと無効である' do
        @order_form.post_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'cityが空だと無効である' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと無効である' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと無効である' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが不正な形式だと無効である' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'tokenが空だと無効である' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end