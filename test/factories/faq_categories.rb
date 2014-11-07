# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq_category, :class => 'Faq::Category' do
    name "MyString"
  end
end
