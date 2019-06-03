FactoryBot.define do
  factory :task do
    name { '書き込みテスト' }
    description { 'RSpec,Capybara,FactoryBotの準備' }
    user
  end
end