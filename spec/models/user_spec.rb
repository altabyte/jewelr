require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Creating a basic user' do
    subject(:user) { FactoryGirl.create(:user) }

    it { is_expected.to be_valid }

    it 'should have a unique ID' do
      expect(user.id).not_to be_nil
      expect(user.id).to be >= 1_000_000
    end

    it 'should have a username' do
      expect(user.username).not_to be_nil
    end

    it 'should have an email address' do
      expect(user.email).not_to be_nil
    end

    it 'should have an authentication token' do
      expect(user.authentication_token).not_to be_nil
      expect(user.authentication_token.length).to eq(User::AUTH_TOKEN_LENGTH)
    end

    it 'should use :en as the default locale' do
      expect(user.locale).to eq(:en)
    end

    it 'prints a field summary' do
      puts "User ID:      #{user.id}"
      puts "Username:     #{user.username}"
      puts "Email:        #{user.email}"
      puts "Locale:       #{user.locale}"
      puts "Auth Token:   #{user.authentication_token}"
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


  describe 'Setting username to nil' do
    subject(:user) { FactoryGirl.create(:user, username: nil) }

    it 'should set the username to the user ID' do
      puts "User ID:      #{user.id}"
      puts "Username:     #{user.username}"
      expect(user.username).to eq(user.id.to_s)
    end
  end
end
