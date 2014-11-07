# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq_question, :class => 'Faq::Question' do
    question "MyString"
    answer "MyText"
  end
end
