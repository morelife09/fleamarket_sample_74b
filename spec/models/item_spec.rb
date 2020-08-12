require 'rails_helper'
describe Item do
  describe '#create' do

    it "商品説明がない場合は登録できないこと" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "説明がない場合は登録できないこと" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "価格が300円以上〜999,999円以下でないと登録できないこと" do
      item = build(:item, price: only_integer: true,greater_than: 300, less_than: 999999)
      expect(item).to be_valid
    end

    it "画像が１枚以上ない場合は登録できないこと" do
      item = build(:item, image: nil)
      item.valid?
      expect(item.errors[:image]).to include("can't be blank")
    end

    it "カテゴリがない場合登録できないこと" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

    it "サイズがない場合登録できないこと" do
      item = build(:item, size_id: nil)
      item.valid?
      expect(item.errors[:size_id]).to include("can't be blank")
    end

    it "商品の状態がない場合登録できないこと" do
      item = build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("can't be blank")
    end

    it "配送料の負担がない場合登録できないこと" do
      item = build(:item, shipping_fee_id: nil)
      item.valid?
      expect(item.errors[:shipping_fee_id]).to include("can't be blank")
    end


    it "発送元の地域がない場合は登録できないこと" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    it "発送までの日数がない場合は登録できないこと" do
      item = build(:item, shipping_date_id: nil)
      item.valid?
      expect(item.errors[:delivery_days_id]).to include("can't be blank")
    end

    it name, "name, description, prefecture_id, seller_id, condition_id, category_id, :size_id, shipping_fee_id, delivery_days_id, price, brand_id, images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)があれば登録できること" do
      item = build(:item)
      expect(item).to be_valid
    end

  end
end