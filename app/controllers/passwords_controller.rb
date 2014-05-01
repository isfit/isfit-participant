class PasswordsController < Devise::PasswordsController
  layout 'landing', only: :new
end
