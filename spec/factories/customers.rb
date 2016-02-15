# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    first_name "Ian"
    last_name "Knauer"
    email "ian.knauer@gmail.com"
  end
end
