FactoryBot.define do
  factory :user do
    name { 'テストユーザ' }
    email { 'test@user.mail' }
    password { 'password' }
  end
end