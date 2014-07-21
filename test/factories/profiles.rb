FactoryGirl.define do
  factory :profile do
    address 'E. Bonanza St.'
    postal_code '80440'
    city 'South Park'

    calling_code 1
    phone '80000100'

    date_of_birth '1996-04-24'
    gender 1
    nationality 'American'

    school 'South Park Elementary'
    field_of_study 'Awesomeness'

    motivation_essay 'Lorem ipsum dolor sit amet.'

    association :user
    association :country
    association :citizenship, factory: :country
  end
end