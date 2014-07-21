require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test 'has valid factory' do
    profile = FactoryGirl.build(:profile)
    assert profile.valid?
  end

  test 'not vaild without address' do
  	profile = FactoryGirl.build(:profile, address: '')
  	assert profile.invalid?
  end

  test 'not vaild without postal code' do
  	profile = FactoryGirl.build(:profile, postal_code: '')
  	assert profile.invalid?
  end

  test 'not vaild without city' do
  	profile = FactoryGirl.build(:profile, city: '')
  	assert profile.invalid?
  end

  test 'not vaild without country' do
  	profile = FactoryGirl.build(:profile, country: nil)
  	assert profile.invalid?
  end

  test 'not vaild without calling code' do
  	profile = FactoryGirl.build(:profile, calling_code: '')
  	assert profile.invalid?
  end

  test 'not vaild without phone' do
  	profile = FactoryGirl.build(:profile, phone: '')
  	assert profile.invalid?
  end

  test 'not vaild without date of birth' do
  	profile = FactoryGirl.build(:profile, date_of_birth: '')
  	assert profile.invalid?
  end

  test 'not vaild without gender' do
  	profile = FactoryGirl.build(:profile, gender: '')
  	assert profile.invalid?
  end

  test 'not vaild without citizenship' do
  	profile = FactoryGirl.build(:profile, citizenship: nil)
  	assert profile.invalid?
  end
  
  test 'not vaild without nationality' do
  	profile = FactoryGirl.build(:profile, nationality: '')
  	assert profile.invalid?
  end

  test 'not vaild without school' do
  	profile = FactoryGirl.build(:profile, school: '')
  	assert profile.invalid?
  end

  test 'not vaild without field_of_study' do
  	profile = FactoryGirl.build(:profile, field_of_study: '')
  	assert profile.invalid?
  end

  test 'not vaild without user' do
  	profile = FactoryGirl.build(:profile, field_of_study: nil)
  	assert profile.invalid?
  end
end
