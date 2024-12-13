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

  describe 'OrderForm validations' do
    context 'valid details' do
      it 'is valid with all details' do
        expect(@order_form).to be_valid
      end
    end

    context 'invalid details' do
      it 'is invalid without a user_id' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'is invalid without an item_id' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'is invalid without a post_code' do
        @order_form.post_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Post code can't be blank")
      end

      it 'is invalid without a prefecture_id' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'is invalid if prefecture_id is 0' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'is invalid with incorrectly formatted post_code' do
        @order_form.post_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'is invalid without a city' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'is invalid without an address' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it 'is invalid without a phone_number' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'is invalid with incorrectly formatted phone_number' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'is invalid without a token' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end