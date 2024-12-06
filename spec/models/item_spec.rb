require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'バリデーション' do
    context '名前のバリデーション' do
      it '名前が空の場合は無効であること' do
        @item = build(:item, name: '')
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end

      it '名前が41文字以上の場合は無効であること' do
        @item = build(:item, name: 'a' * 41)
        @item.valid?
        expect(@item.errors[:name]).to include('is too long (maximum is 40 characters)')
      end
    end

    context '説明文のバリデーション' do
      it '説明文が空の場合は無効であること' do
        @item = build(:item, description: '')
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it '説明文が1001文字以上の場合は無効であること' do
        @item = build(:item, description: 'a' * 1001)
        @item.valid?
        expect(@item.errors[:description]).to include('is too long (maximum is 1000 characters)')
      end
    end

    context '価格のバリデーション' do
      it '価格が空の場合は無効であること' do
        @item = build(:item, price: nil)
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it '価格が整数でない場合は無効であること' do
        @item = build(:item, price: 500.5)
        @item.valid?
        expect(@item.errors[:price]).to include('must be an integer')
      end

      it '価格が300未満の場合は無効であること' do
        @item = build(:item, price: 299)
        @item.valid?
        expect(@item.errors[:price]).to include('must be greater than or equal to 300')
      end

      it '価格が9,999,999を超える場合は無効であること' do
        @item = build(:item, price: 10_000_000)
        @item.valid?
        expect(@item.errors[:price]).to include('must be less than or equal to 9999999')
      end
    end

    context '関連IDのバリデーション' do
      it 'category_idが空の場合は無効であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end

      it 'category_idが1以下の場合は無効であること' do
        @item = build(:item, category_id: 1)
        @item.valid?
        expect(@item.errors[:category_id]).to include('must be greater than 1')
      end

      it 'condition_idが空の場合は無効であること' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors[:condition_id]).to include("can't be blank")
      end

      it 'shipping_fee_idが空の場合は無効であること' do
        @item.shipping_fee_id = nil
        @item.valid?
        expect(@item.errors[:shipping_fee_id]).to include("can't be blank")
      end

      it 'prefecture_idが空の場合は無効であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end

      it 'shipping_day_idが空の場合は無効であること' do
        @item.shipping_day_id = nil
        @item.valid?
        expect(@item.errors[:shipping_day_id]).to include("can't be blank")
      end
    end
  end
end
