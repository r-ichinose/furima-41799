require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
  end

  describe 'バリデーション' do
    context '正常系' do
      it '全ての値が適切に設定されている場合、保存が成功すること' do
        expect(@item).to be_valid
        expect(@item.save).to be true
        expect(@item.errors.full_messages).to be_empty
      end

      it '名前が40文字の場合、有効であること' do
        @item.name = 'A' * 40
        expect(@item).to be_valid
      end

      it '説明文が1000文字の場合、有効であること' do
        @item.description = 'A' * 1000
        expect(@item).to be_valid
      end

      it '価格が300から9,999,999の範囲内の場合、有効であること' do
        @item.price = 300
        expect(@item).to be_valid
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '無効系' do
      it '名前が空の場合は無効であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end

      it '名前が41文字以上の場合は無効であること' do
        @item.name = 'A' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include "Name is too long (maximum is 40 characters)"
      end

      it '説明文が空の場合は無効であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end

      it '説明文が1001文字以上の場合は無効であること' do
        @item.description = 'A' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include "Description is too long (maximum is 1000 characters)"
      end

      it '価格が空の場合は無効であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '価格が整数でない場合は無効であること' do
        @item.price = 'a100'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end

      it '価格が300未満の場合は無効であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end

      it '価格が9,999,999を超える場合は無効であること' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be less than or equal to 9999999"
      end

      it 'category_idが1の場合は無効であること' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category must be greater than 1"
      end
      
      it 'condition_idが1の場合は無効であること' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition must be greater than 1"
      end
      
      it 'shipping_fee_idが1の場合は無効であること' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee must be greater than 1"
      end
      
      it 'prefecture_idが1の場合は無効であること' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture must be greater than 1"
      end
      
      it 'shipping_day_idが1の場合は無効であること' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping day must be greater than 1"
      end

      it '画像が添付されていない場合は無効であること' do
        @item.image.purge
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end

      it 'userが紐づいていない場合は無効であること' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "User must exist"
      end
    end
  end
end