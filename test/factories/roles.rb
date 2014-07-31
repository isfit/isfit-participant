FactoryGirl.define do
  factory :role do
    name 'applicant'

    factory :admin_role do
      name 'admin'
    end
  end
end