require 'rails_helper'

RSpec.describe Colour, type: :model do

  let(:description) { FactoryGirl.create(:description) }

  describe 'initialize' do

    let(:colour_name) { 'Royal Blue' }

    context 'Fixnum' do

      context '0' do
        subject(:colour) { Colour.create(rgb: 0, description: description) }

        it { is_expected.to be_valid }

        it { expect(colour.to_i).to eq(0) }

        it { expect(colour.rgb).not_to be_nil }

        it { expect(colour.rgb.hex).to eq('000000') }

        it 'has H, S & L values of zero' do
          expect(colour.hue).to eq(0)
          expect(colour.saturation).to eq(0)
          expect(colour.luminosity).to eq(0)
        end

        it { expect(colour.hex).to eq('000000') }
      end

      context 'Royal Blue' do
        subject(:colour) { Colour.create(rgb: 4286945, description: description) }

        it { is_expected.to be_valid }

        it 'has H, S & L values' do
          expect(colour.hue).to be_within(0.05).of(225)
          expect(colour.saturation).to be_within(0.05).of(72.72)
          expect(colour.luminosity).to be_within(0.05).of(56.86)

          puts
          puts 'Royal Blue'
          puts "  Hue:        #{colour.hue}"
          puts "  Saturation: #{colour.saturation}"
          puts "  Luminosity: #{colour.luminosity}"
        end
      end
    end


    context 'from Color:RGB' do
      let(:rgb) { Color::RGB.new(65, 105, 225) }

      subject(:colour) { Colour.create(rgb: rgb, description: description) }

      it { is_expected.to be_valid }

      it 'has H, S & L values' do
        expect(colour.hue).to eq(225)
        expect(colour.saturation).to be_within(0.05).of(72.73)
        expect(colour.luminosity).to be_within(0.05).of(56.86)
      end
    end

    context 'from hex string' do

      context 'valid' do
        subject(:colour) { Colour.create(rgb: '#4169E1', description: description) }

        it { is_expected.to be_valid }

        it 'has H, S & L values' do
          expect(colour.hue).to eq(225)
          expect(colour.saturation).to be_within(0.05).of(72.73)
          expect(colour.luminosity).to be_within(0.05).of(56.86)
        end
      end

      context 'invalid' do
        subject(:colour) { Colour.create(rgb: 'ZZZZ', description: description) }

        it 'has no values set' do
          is_expected.not_to be_valid
          expect(colour.rgb).to be_nil
          expect(colour.hue).to be_nil
          expect(colour.saturation).to be_nil
          expect(colour.luminosity).to be_nil
        end
      end
    end
  end


  describe 'name' do
    it { is_expected.to respond_to :named_colour_list }

    # Greyscale colours have a Hue of 0°
    context 'Greyscale colours' do

      it 'Classifies very dark greys as black' do
        %w'#000000 #111111 #222222'.each do |hex|
          colour = Colour.create(rgb: hex, description: description)
          expect(colour.name).to eq('Black')
        end
      end

      it 'Classifies dark greys as dark-grey' do
        %w'#303030'.each do |hex|
          colour = Colour.create(rgb: hex, description: description)
          expect(colour.name).to eq('Dark Grey')
        end
      end
    end

    context 'Cherry pink' do
      subject(:colour) { Colour.create(rgb: '#E61870', description: description) }

      it { expect(colour.name).to eq('Cherry') }
      it { expect(colour.name(:en)).to eq('Cherry') }
      it { expect(colour.name(:xyz)).to eq('Cherry') }
      it { expect(colour.name(:ebay)).to eq('Pink') }
      it { expect(colour.name(:amazon)).to eq('Pink') }
    end

    context 'Jasper' do
      subject(:colour) { Colour.create(rgb: '#D73B3E', description: description) }
      it { expect(colour.name).to eq('Jasper') }
    end

    context 'Redwood' do
      subject(:colour) { Colour.create(rgb: '#A45A52', description: description) }
      it { expect(colour.name).to eq('Redwood') }
    end
  end
end
