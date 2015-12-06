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


  describe 'part_count' do
    subject(:description) { FactoryGirl.create(:description) }

    it { should validate_presence_of(:part_count) }

    context 'when not defined' do
      it { expect(description.part_count).to eq(1) }
    end

    context 'when not valid' do
      it 'does not accept values less than 1' do
        description.part_count = 0
        expect(description).not_to be_valid
        expect(description.errors).to have_key(:part_count)
      end

      it 'does not accept null' do
        description.part_count = nil
        expect(description).not_to be_valid
        expect(description.errors).to have_key(:part_count)
      end
    end
  end


  describe 'colours' do
    subject(:description) { FactoryGirl.create(:description) }

    let(:aquamarine)    { Colour.new(rgb: '#7FFFD4') }
    let(:pink_sherbet)  { Colour.new(rgb: '#F78FA7') }

    it { is_expected.to have_many(:colours) }
    it { expect(description.colours).not_to be_nil }

    context 'none' do
      it { expect(description.colours).to be_empty }
    end

    context 'single colour' do
      it 'saves the colour' do
        description.colours << pink_sherbet
        expect(description.save).to be true
        expect(description.colours).not_to be_empty
        expect(description.colours.count).to eq(1)
      end
    end

    context 'duplicate colours' do
      before do
        description.colours << Colour.new(rgb: aquamarine.rgb)
        description.colours << Colour.new(rgb: aquamarine.rgb)
        description.colours << Colour.new(rgb: pink_sherbet.rgb)
        description.colours << Colour.new(rgb: aquamarine.rgb)
        description.colours << Colour.new(rgb: pink_sherbet.rgb)
        expect(description.save).to be true
        description.reload
      end

      it 'should only have two colours' do
        expect(description.colours.count).to eq(2)
      end

      it 'should have aquamarine as the 1st colour in the list' do
        expect(description.colours.first.rgb).to eq(aquamarine.rgb)
        expect(description.colours.first.position).to eq(1)
      end

      it 'should have pink_sherbet as the last colour in the list' do
        expect(description.colours.last.rgb).to eq(pink_sherbet.rgb)
        expect(description.colours.last.position).to eq(2)
      end

      it 'should not clash with a second description' do
        description_2 = FactoryGirl.create(:description)

        description_2.colours << Colour.new(rgb: aquamarine.rgb)
        description_2.colours << Colour.new(rgb: aquamarine.rgb)
        description_2.colours << Colour.new(rgb: pink_sherbet.rgb)
        description_2.colours << Colour.new(rgb: aquamarine.rgb)
        description_2.colours << Colour.new(rgb: pink_sherbet.rgb)

        expect(description_2.colours.count).to eq(2)
        expect(description.colours.count).to eq(2)
      end
    end
  end


  describe 'notes' do
    context 'when blank' do
      [nil, '', '   '].each do |notes|
        subject(:description) { FactoryGirl.create(:description, notes: notes) }
        it { expect(description.notes).to be_nil }
        it { expect(description.notes?).to be false }
      end
    end

    context 'when valid text' do
      subject(:description) { FactoryGirl.create(:description, notes: '  This   is   some   notes.  ') }

      it { expect(description.notes).not_to be_nil }
      it { expect(description.notes?).to be true }
      it { expect(description.notes).to eq('This is some notes.') }
    end
  end


  describe 'summary' do
    context 'when blank' do
      [nil, '', '   '].each do |summary|
        subject(:description) { FactoryGirl.create(:description, summary: summary) }
        it { expect(description.summary).to be_nil }
        it { expect(description.summary?).to be false }
      end
    end

    context 'when valid text' do
      subject(:description) { FactoryGirl.create(:description, summary: '  This is a *bold* summary.  ') }

      it { expect(description.summary).not_to be_nil }
      it { expect(description.summary?).to be true }
      it { expect(description.summary).to eq('This is a *bold* summary.') }
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

  describe 'shop_sec legacy SKUs' do
    it { is_expected.to respond_to :shop_sec_account }
    it { is_expected.to respond_to :shop_sec_sku }
    it { is_expected.to respond_to 'shop_sec_AR?' }
    it { is_expected.to respond_to 'shop_sec_AR!' }
    it { is_expected.to respond_to 'shop_sec_TT?' }
    it { is_expected.to respond_to 'shop_sec_TT!' }

    context 'when not defined' do
      subject(:description) { FactoryGirl.create(:description) }
      it { expect(description.shop_sec_account).to be_nil }
      it { expect(description.shop_sec_sku).to be_nil }
    end

    context 'when TT' do
      let(:sku) { 12345 }
      subject(:description) { FactoryGirl.create(:description, shop_sec_account: 1, shop_sec_sku: sku) }
      it { expect(description.shop_sec_sku).to eq(sku) }
      it { expect(description.shop_sec_account).not_to be_nil }
      it { expect(description.shop_sec_account).to eq('shop_sec_TT') }
      it { expect(description).to be_shop_sec_TT }
    end
  end
end
