require 'rails_helper'
require_relative 'concerns/locale_nameable_spec'

RSpec.describe Material, type: :model do
  it_should_behave_like 'Locale Nameable'

  it { is_expected.to be_a_closure_tree }

  it { is_expected.to validate_presence_of(:type) }

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
    # @see 'concerns/locale_nameable_spec'
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
