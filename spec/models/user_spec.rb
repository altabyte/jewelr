require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Creating a basic user' do
    subject(:user) { FactoryGirl.create(:user) }

    it { is_expected.to be_valid }

    it 'should have a unique ID' do
      expect(user.id).not_to be_nil
      puts "User ID:      #{user.id}"
    end

    it 'should have a username' do
      expect(user.username).not_to be_nil
      puts "Username:     #{user.username}"
    end

    it 'should have an email address' do
      expect(user.email).not_to be_nil
      puts "Email:        #{user.email}"
    end

    it 'should have an authentication token' do
      expect(user.authentication_token).not_to be_nil
      expect(user.authentication_token.length).to eq(User::AUTH_TOKEN_LENGTH)
      puts "Auth Token:   #{user.authentication_token}"
    end

    it 'should use :en as the default locale' do
      expect(user.locale).to eq(:en)
      puts "Locale:       #{user.locale}"
    end
  end


  describe 'Setting the user locale' do
    subject(:user) { FactoryGirl.create(:user) }

    it 'should have :en as the default locale' do
      expect(user.locale).to eq(:en)
    end

    it 'should accept :zh as valid a locale' do
      user.locale = :zh
      expect(user.save).to be true
      expect(user.locale).to eq(:zh)
      user.reload
      expect(user.locale).to eq(:zh)
    end

    it 'should ignore invalid locales, such as :pl' do
      user.locale = :pl
      expect(user.locale).to eq(:en)
    end
  end
end
