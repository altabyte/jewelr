require 'rails_helper'

RSpec.shared_examples 'Locale Nameable' do

  let(:model) { described_class } # the class that includes the concern
  let(:valid_name_en) { 'English name' }
  let(:valid_name_zh) { '中国名' }

  describe 'names' do
    subject(:nameable) { FactoryGirl.create(model) }

    it { is_expected.to respond_to :names }
    it { expect(nameable.names).to be_a(Hash) }
  end


  describe 'name' do
    subject(:nameable) { FactoryGirl.build(model, name_en: valid_name_en, name_zh: valid_name_zh) }

    it 'should return the :en name by default' do
      expect(nameable.name).to eq(valid_name_en)
    end

    it 'should return the :en name' do
      expect(nameable.name(:en)).to eq(valid_name_en)
    end

    it 'should return the :zh name' do
      expect(nameable.name(:zh)).to eq(valid_name_zh)
    end

    it 'falls back to :en if locale not found' do
      expect(nameable.name(:zz)).to eq(valid_name_en)
    end
  end


  describe 'name_en' do

    context 'when valid' do
      subject(:nameable) { FactoryGirl.create(model, name_en: valid_name_en) }

      it { is_expected.to have(0).errors_on(:name_en) }

      it 'is accessible via store_accessor alias and Hash keys' do
        expect(nameable.name_en).to eq(valid_name_en)
        expect(nameable.names['name_en']).to eq(valid_name_en)
        expect(nameable.names[:name_en]).to eq(valid_name_en)
        puts nameable.name_en
      end
    end

    context 'when nil' do
      subject(:nameable) { FactoryGirl.build(model, name_en: nil) }
      it { is_expected.not_to be_valid }
      it { is_expected.to have(1).errors_on(:name_en) }
    end
  end


  describe 'name_zh' do
    context 'when empty string' do
      subject(:nameable) { FactoryGirl.create(model, name_zh: '  ') }

      it { is_expected.to be_valid }
      it { expect(nameable.name_zh).to be_nil }
    end

    context 'when nil' do
      subject(:nameable) { FactoryGirl.create(model, name_zh: nil) }

      it { is_expected.to be_valid }
      it { expect(nameable.name_zh).to be_nil }
    end
  end


  context 'when excess white space in names' do
    subject(:nameable) { FactoryGirl.create(model, name_en: '  material   1   name  ', name_zh: '  宝  石  ', name_pinyin: '  gemstonename  ') }

    it { expect(nameable.name_en).to eq('material 1 name') }
    it { expect(nameable.name_zh).to eq('宝 石') }
    it { expect(nameable.name_pinyin).to eq('gemstonename') }
  end


  describe 'uniqueness' do
    pending 'TODO: `validates :name_en, uniqueness: true` does not work!!'
  end
end
