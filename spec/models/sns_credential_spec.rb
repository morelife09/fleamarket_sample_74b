require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
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
end
