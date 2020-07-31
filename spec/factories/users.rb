FactoryBot.define do

  factory :user do
    nickname              {"abc"}
    email                 {"yyy@gmail.com"}
    password              {"0000000"}
    password_confirmation {"0000000"}
    first_name            {"aaa"}
    family_name           {"aaa"}
    first_name_furigana   {"aaa"}
    family_name_furigana  {"aaa"}
    birth_date            {"2020-01-01"}
  end

end