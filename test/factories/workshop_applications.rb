# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workshop_application do
    workshop_1 nil
    workshop_2 nil
    workshop_3 nil
    workshop_essay "MyText"
    applying_for_support false
    amount 1
    other_sources false
    still_attend false
  end
end
