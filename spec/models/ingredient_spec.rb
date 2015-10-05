require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  it { should belong_to(:description) }
  it { should belong_to(:material) }

  let(:description) { FactoryGirl.create(:description) }
  let(:material_1)  { FactoryGirl.create(:gemstone) }

  describe 'Adding materials to description' do

    it { expect(description.materials.count).to eq(0) }
    it { expect(description.ingredients.count).to eq(0) }

    it 'Has the correct number of ingredients' do
      (1..9).each do |i|
        description.materials << FactoryGirl.create(:gemstone)
        expect(description.materials.count).to eq(i)
        expect(description.ingredients.count).to eq(i)

        expect(description).to be_valid
        expect(description.save).to be true
        description.reload

        expect(description.materials.count).to eq(i)
        expect(description.ingredients.count).to eq(i)
      end
    end
  end

  context 'The 1st ingredient' do

    subject(:ingredient) do
      description.materials << material_1
      description.ingredients.first
    end

    # All ingredients should be genuine by default.
    # An example of setting to false would be for synthetic turquoise.
    describe 'Genuine' do
      it { is_expected.to be_genuine }
    end

    # Allow a String adjective to be pre-pended to the ingredient.
    # Eg. Material is 'Agate' but I wish to display 'Green Agate'.
    # This field is for future use and is not currently queried in this app.
    describe 'Adjective' do
      it { expect(subject.adjective).to be_nil }
    end

    describe 'Significance enumeration' do
      # http://api.rubyonrails.org/v4.2.0/classes/ActiveRecord/Enum.html

      describe 'Values' do
        it 'should have 3 significance values' do
          expect(Ingredient.significances.count).to eq(3)
          expect(Ingredient.significances[:primary]).to eq(0)
          expect(Ingredient.significances[:secondary]).to eq(1)
          expect(Ingredient.significances[:tertiary]).to eq(2)
        end
      end

      describe 'Default value' do
        it { expect(subject.significance).to eq('primary') }
        it { expect(subject).to be_primary }
        it { expect(subject).not_to be_secondary }
        it { expect(subject).not_to be_tertiary }
      end

      describe 'Changing significance' do
        it  'should change to :secondary' do
          subject.significance = :secondary
          expect(subject).to be_secondary
        end

        it 'should change to :tertiary' do
          subject.tertiary!
          expect(subject).to be_tertiary
        end
      end
    end
  end


  describe 'Adding dublicate materials' do

    it 'should prevent dublicates' do
      description.materials << material_1
      expect(description.materials.count).to eq(1)

      description.materials << material_1  # Same material again!
      expect(description.materials.count).not_to eq(2)
      expect(description.materials.count).to eq(1)
    end
  end


  describe 'acts-as-list' do

    let(:material_count) { 5 }
    before do
      (1..material_count).each do |i|
        description.materials << FactoryGirl.create(:gemstone, name_en: "Gemstone #{i}")
        description.save!
        description.reload
      end
    end

    it { expect(description.materials.count).to eq(material_count) }

    it 'Moves the 4th material to the 2nd position in the list' do
      ingredient = description.ingredients[3]
      expect(ingredient.position).to eq(4)
      expect(ingredient.name).to eq('Gemstone 4')
      ingredient.set_list_position(2)
      description.save!
      description.reload
      expect(ingredient.position).to eq(2)
      description.ingredients.each { |i| puts "#{i.position} =>  '#{i.name}'" }
    end
  end
end
