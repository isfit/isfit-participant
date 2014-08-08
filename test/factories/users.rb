FactoryGirl.define do
  factory :user do
    first_name            'Eric'
    last_name             'Cartman'
    email                 'ericcartman@example.com'
    email_confirmation    'ericcartman@example.com'
    password              'secret'
    password_confirmation 'secret'

    factory :admin_user do
      role 'admin'
    end
  end
end