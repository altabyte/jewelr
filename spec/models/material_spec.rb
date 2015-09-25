require 'rails_helper'

RSpec.describe Material, type: :model do

  describe 'Primary key ID' do
    subject(:material) { FactoryGirl.build(:gemstone) }

    it 'should assign a 7-digit UID before the material is created' do
      expect(material.id).to be nil
      expect(material.save).to be true
      material.reload
      expect(material.id).not_to be nil
      expect(material.id.to_s).to match(/[0-9]{7}/)
      puts "Material ID: #{material.id}"
    end

    it 'should also allow an ID to be manually assigned' do
      material.id = 1234567
      expect(material.save).to be true
      expect(material.id).not_to be nil
      expect(material.id).to eq(1234567)
    end
  end

  describe 'Names' do

    let(:name_en) { 'material name' }
    let(:name_zh) { '宝石' }

    describe 'name_en' do
      context 'when valid' do

        subject(:material) { FactoryGirl.create(:gemstone, name_en: name_en) }
        it { is_expected.to have(0).errors_on(:name_en) }

        it 'is accessible via store_accessor alias and Hash keys' do
          expect(material.name_en).to eq(name_en)
          expect(material.names['name_en']).to eq(name_en)
          expect(material.names[:name_en]).to eq(name_en)
          puts material.name_en
        end
      end

      context 'when nil' do
        subject(:material) { FactoryGirl.build(:gemstone, name_en: nil) }
        it { is_expected.not_to be_valid }
        it { is_expected.to have(1).errors_on(:name_en) }
      end
    end


    describe 'name_zh' do
      context 'when empty string' do
        subject(:material) { FactoryGirl.create(:gemstone, name_en: name_en, name_zh: '  ') }

        it { is_expected.to be_valid }
        it { expect(material.name_zh).to be_nil }
      end

      context 'when nil' do
        subject(:material) { FactoryGirl.create(:gemstone, name_en: name_en, name_zh: nil) }

        it { is_expected.to be_valid }
        it { expect(material.name_zh).to be_nil }
      end
    end


    describe 'name' do
      subject(:material) { FactoryGirl.build(:gemstone, name_en: name_en, name_zh: name_zh) }

      it 'should return the :en name by default' do
        expect(material.name).to eq(name_en)
      end

      it 'should return the :en name' do
        expect(material.name(:en)).to eq(name_en)
      end

      it 'should return the :zh name' do
        expect(material.name(:zh)).to eq(name_zh)
      end

      it 'falls back to :en if locale not found' do
        expect(material.name(:zz)).to eq(name_en)
      end
    end


    context 'when excess white space in names' do
      subject(:material) { FactoryGirl.create(:gemstone, name_en: '  material   1   name  ', name_zh: '  宝  石  ', name_pinyin: '  gemstonename  ') }

      it { expect(material.name_en).to eq('material 1 name') }
      it { expect(material.name_zh).to eq('宝 石') }
      it { expect(material.name_pinyin).to eq('gemstonename') }
    end


    describe 'uniqueness' do
      pending 'TODO: `validates :name_en, uniqueness: true` does not work!!'
    end
  end


  describe 'aliases' do
    describe 'alias_en' do
      context 'none' do
        subject(:material) { FactoryGirl.create(:gemstone, alias_en: nil) }

        it 'should be an empty array' do
          expect(material.alias_en).to be_a(Array)
          expect(material.alias_en).to be_empty
        end
      end

      context 'string' do
        let(:alias_en) { 'Also known as material 2' }
        subject(:material) { FactoryGirl.create(:gemstone, alias_en: alias_en) }

        it 'should be a single element array' do
          expect(material.alias_en).to be_a(Array)
          expect(material.alias_en.size).to eq(1)
          expect(material.alias_en).to have(1).alias
          expect(material.alias_en.first).to eq(alias_en)
        end
      end

      context 'CSV' do
        let(:alias_en) { 'Material 3, , Material 2, Material 1' }
        subject(:material) { FactoryGirl.create(:gemstone, alias_en: alias_en) }

        it 'should be a 3-element array' do
          expect(material.alias_en).to be_a(Array)
          expect(material.alias_en).to have(3).alias
        end

        it 'should sort the alphabetically' do
          expect(material.alias_en.first).to eq('Material 1')
        end
      end
    end
  end


  describe 'inherit_display_name' do
    subject(:material) do
      attributes = FactoryGirl.attributes_for(:gemstone).except(:inherit_display_name)
      Material.create(attributes)
    end

    it 'does not inherit_display_name by default' do
      is_expected.not_to be_inherit_display_name
    end
  end


  describe 'selectable' do
    subject(:material) do
      attributes = FactoryGirl.attributes_for(:gemstone).except(:selectable)
      Material.create(attributes)
    end

    it 'is selectable by default' do
      is_expected.to be_selectable
    end
  end


  describe 'description' do
    subject(:material) { FactoryGirl.build(:gemstone, description: nil) }

    it { expect(material.description).to be nil }
    it { expect(material).not_to be_description }

    it 'should add a description' do
      desc = 'This is the gemstone description'
      material.description = desc
      expect(material.save).to be true
      material.reload
      expect(material.description).not_to be nil
      expect(material.description).to eq(desc)
      material.description = ' '
      expect(material.save).to be true
      expect(material.description).to be nil
    end
  end


  describe 'Adding private notes' do
    subject(:material) { FactoryGirl.build(:gemstone, notes: nil) }

    it { expect(material.notes).to be nil }
    it { expect(material).not_to be_notes }

    it 'should add a notes' do
      note = 'This is the gemstone private note'
      material.notes = note
      expect(material.save).to be true
      material.reload
      expect(material.notes).not_to be nil
      expect(material.notes).to eq(note)
      material.notes = ' '
      expect(material.save).to be true
      expect(material.notes).to be nil
    end
  end


  describe 'STI' do

    describe 'type_names' do
      let(:names) { [Material::Gemstone.name, Material::Metal.name, Material::ManMade.name] }

      it 'has the above mentioned list of type_names' do
        Material.type_names.each do |name|
          expect(names).to include(name)
          puts "Valid material type name:  #{name}"
        end
      end
    end

    describe 'Materials' do
      let(:attributes) { FactoryGirl.attributes_for(:material).except(:type) }
      subject(:material) { Material.new(attributes) }

      it 'should not allow non-subclassed Material to be persisted' do
        is_expected.not_to be_valid
        is_expected.to have(1).errors_on(:type)
        expect(material.save).to be false
      end


    end

    describe 'Gemstones' do
      let(:attributes) { FactoryGirl.attributes_for(:gemstone).except(:type) }
      subject(:material) { Material::Gemstone.create(attributes) }

      it { expect(attributes).not_to have_key(:type) }

      it 'should be of the correct type' do
        expect(material.type).not_to be_nil
        expect(material.type).to eq('Material::Gemstone')
        expect(material.type_class).to eq(Material::Gemstone)
        expect(material).to be_gemstone
        puts material.type
      end
    end

    describe 'Metals' do
      subject(:material) { Material::Metal.create(FactoryGirl.attributes_for(:metal).except(:type)) }

      it 'should be of the correct type' do
        expect(material.type).not_to be_nil
        expect(material.type).to eq('Material::Metal')
        expect(material.type_class).to eq(Material::Metal)
        expect(material).to be_metal
        puts material.type
      end
    end

    describe 'Man-mades' do
      subject(:material) { Material::ManMade.create(FactoryGirl.attributes_for(:material).except(:type)) }

      it 'should be of the correct type' do
        expect(material.type).not_to be_nil
        expect(material.type).to eq('Material::ManMade')
        expect(material.type_class).to eq(Material::ManMade)
        expect(material).to be_man_made
        puts material.type
      end
    end
  end
end
