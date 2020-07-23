require 'rails_helper'
describe User do
  describe '#create' do

    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "重複したemailは登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "passwordとpassword_confirmationが一致しないと登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "passwordが７文字以上なら登録できること" do
      user = build(:user, password: "0000000")
      expect(user).to be_valid
    end

    it "passwordが６文字以下なら登録できないこと" do
      user = build(:user, password: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "family_nameがない場合は登録できないこと" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "first_name_furiganaがない場合は登録できないこと" do
      user = build(:user, first_name_furigana: nil)
      user.valid?
      expect(user.errors[:first_name_furigana]).to include("can't be blank")
    end

    it "family_name_furiganaがない場合は登録できないこと" do
      user = build(:user, family_name_furigana: nil)
      user.valid?
      expect(user.errors[:family_name_furigana]).to include("can't be blank")
    end

    it "birth_dateがない場合は登録できないこと" do
      user = build(:user, birth_date: nil)
      user.valid?
      expect(user.errors[:birth_date]).to include("can't be blank")
    end

    it "nickname, email,password, password_confirmation, first_name, fmaily_name, first_name_furigana, family_name_furigana, birth_date があれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

  end
end