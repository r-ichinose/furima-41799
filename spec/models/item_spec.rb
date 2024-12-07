require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.build(:item, user: user) }

  before do
    item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
  end

  describe 'バリデーション' do
    context '正常系' do
      it '名前が40文字の場合、有効であること' do
        item.name = 'A' * 40
        expect(item).to be_valid
      end

      it '説明文が1000文字の場合、有効であること' do
        item.description = 'A' * 1000
        expect(item).to be_valid
      end

      it '価格が300から9,999,999の範囲内の場合、有効であること' do
        item.price = 300
        expect(item).to be_valid
        item.price = 9_999_999
        expect(item).to be_valid
      end
    end

    context '無効系' do
      it '名前が空の場合は無効であること' do
        item.name = ''
        expect(item).to_not be_valid
      end

      it '名前が41文字以上の場合は無効であること' do
        item.name = 'A' * 41
        expect(item).to_not be_valid
      end

      it '説明文が空の場合は無効であること' do
        item.description = ''
        expect(item).to_not be_valid
      end

      it '説明文が1001文字以上の場合は無効であること' do
        item.description = 'A' * 1001
        expect(item).to_not be_valid
      end

      it '価格が空の場合は無効であること' do
        item.price = nil
        expect(item).to_not be_valid
      end

      it '価格が整数でない場合は無効であること' do
        item.price = 'a100'
        expect(item).to_not be_valid
      end

      it '価格が300未満の場合は無効であること' do
        item.price = 299
        expect(item).to_not be_valid
      end

      it '価格が9,999,999を超える場合は無効であること' do
        item.price = 10_000_000
        expect(item).to_not be_valid
      end

      it 'category_idが1以下の場合は無効であること' do
        item.category_id = 1
        expect(item).to_not be_valid
      end

      it 'condition_idが1以下の場合は無効であること' do
        item.condition_id = 1
        expect(item).to_not be_valid
      end

      it 'shipping_fee_idが1以下の場合は無効であること' do
        item.shipping_fee_id = 1
        expect(item).to_not be_valid
      end

      it 'prefecture_idが1以下の場合は無効であること' do
        item.prefecture_id = 1
        expect(item).to_not be_valid
      end

      it 'shipping_day_idが1以下の場合は無効であること' do
        item.shipping_day_id = 1
        expect(item).to_not be_valid
      end
    end
  end
end