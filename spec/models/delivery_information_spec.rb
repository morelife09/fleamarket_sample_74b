require 'rails_helper'
describe DeliveryInformation do
  describe '#create' do

    it "prefecture_idがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, prefecture_id: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:prefecture_id]).to include("can't be blank")
    end

    it "delivery_family_nameがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, delivery_family_name: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:delivery_family_name]).to include("can't be blank")
    end

    it "delivery_first_nameがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, delivery_first_name: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:delivery_first_name]).to include("can't be blank")
    end

    it "delivery_family_name_furiganaがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, delivery_family_name_furigana: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:delivery_family_name_furigana]).to include("can't be blank")
    end

    it "delivery_first_name_furiganaがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, delivery_first_name_furigana: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:delivery_first_name_furigana]).to include("can't be blank")
    end

    it "postal_codeがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, postal_code: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:postal_code]).to include("can't be blank")
    end

    it "cityがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, city: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:city]).to include("can't be blank")
    end

    it "addressがない場合は登録できないこと" do
      delivery_information = build(:delivery_information, address: nil)
      delivery_information.valid?
      expect(delivery_information.errors[:address]).to include("can't be blank")
    end

    it "prefecture_id, delivery_family_name, delivery_first_name, delivery_family_name_furigana, delivery_first_name_furigana, postal_code, city, addressがあれば登録できること" do
      delivery_information = build(:delivery_information)
      expect(delivery_information).to be_valid
    end

  end
end