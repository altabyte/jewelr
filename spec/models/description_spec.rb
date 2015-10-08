require 'rails_helper'

RSpec.describe Description, type: :model do

  it { is_expected.to accept_nested_attributes_for(:ingredients) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to have_many(:ingredients) }
  it { is_expected.to have_many(:materials).through(:ingredients) }

  describe 'The FactoryGirl default models' do
    subject(:description) { FactoryGirl.create(:description) }
    it { is_expected.not_to be_nil }
    it { is_expected.to be_valid }
  end


  describe 'acc_price' do
    context 'when nil' do
      subject(:description) { FactoryGirl.create(:description, acc_price: nil) }
      it { is_expected.to be_valid }
      it { expect(description.acc_price).to be_nil }
    end

    context 'when GBP' do
      let(:cents)    { 12_99 }
      let(:currency) { 'GBP' }
      subject(:description) { FactoryGirl.create(:description, acc_price: Money.new(cents, currency)) }

      it { is_expected.to be_valid }
      it { expect(description.acc_price).not_to be_nil }
      it { expect(description.acc_price.cents).to eq(cents) }
      it { expect(description.acc_price.currency).to eq(currency) }
    end
  end


  describe 'target_price' do
    context 'when nil' do
      subject(:description) { FactoryGirl.create(:description, target_price: nil) }
      it { is_expected.to be_valid }
      it { expect(description.target_price).to be_nil }
    end

    context 'when GBP' do
      let(:cents)    { 12_99 }
      let(:currency) { 'GBP' }
      subject(:description) { FactoryGirl.create(:description, target_price: Money.new(cents, currency)) }

      it { is_expected.to be_valid }
      it { expect(description.target_price).not_to be_nil }
      it { expect(description.target_price.cents).to eq(cents) }
      it { expect(description.target_price.currency).to eq(currency) }
    end
  end


  describe 'archived' do
    it { is_expected.to respond_to(:archived?) }

    context 'nil' do
      subject(:description) { FactoryGirl.create(:description, archived: nil) }

      it { is_expected.to be_valid }
      it { is_expected.not_to be_archived }
    end

    context 'time' do
      subject(:description) { FactoryGirl.create(:description, archived: Time.now.utc) }
      it { is_expected.to be_valid }
      it { is_expected.to be_archived }
    end

    context 'time string' do
      let(:time_string) { '2014-07-21T18:30+00:00' }
      subject(:description) { FactoryGirl.create(:description, archived: time_string) }

      it {
        is_expected.to be_archived
        puts "Archived: #{description.archived}"
      }
    end

    context 'booleans' do
      let(:values) { %w'1 true y yes' }
      subject(:description) { FactoryGirl.create(:description, archived: nil) }

      it { is_expected.not_to be_archived }

      it 'accepts integers' do

        description.archived = 1
        is_expected.to be_archived

        description.archived = 0
        is_expected.not_to be_archived

        description.archived = 2
        is_expected.not_to be_archived
      end
    end
  end
end
