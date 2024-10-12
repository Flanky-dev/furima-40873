require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    # Create a user and an item for the purchase process
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user:)

    # Mocking token (assuming you're using a service like PAY.JP)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id,
                                                        token: 'tok_abcdefghijk00000000000000000')
    expect(@order_shipping).to be_valid
    sleep(0.1) # adding sleep to reduce database load (optional)
  end

  describe '購入情報の保存' do
    context '購入ができる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping).to be_valid
      end

      it '建物名は空でも保存できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '購入ができない場合' do
      it 'クレジットカード情報が正しくないと保存できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では保存できないこと' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンがないと保存できないこと' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が空では保存できないこと' do
        @order_shipping.prefecture_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県の情報が0では保存できないこと' do
        @order_shipping.prefecture_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では保存できないこと' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できないこと' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できないこと' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は9桁以下では保存できないこと' do
        @order_shipping.phone_number = '0901234'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number without hyphen')
      end

      it '電話番号は12桁以上では保存できないこと' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number without hyphen')
      end

      it '電話番号はハイフンがあると保存できないこと' do
        @order_shipping.phone_number = '090-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid. Input only number without hyphen')
      end

      it 'クレジットカード情報が必須であること' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
