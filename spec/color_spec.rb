require 'rails_helper'

RSpec.describe Fixnum do
  describe 'The mixed-in to_rbg method' do
    subject { 12345678 }

    it { is_expected.to respond_to :to_rgb }

    it 'Should produce an RGB hash' do
      rgb = subject.to_rgb
      expect(rgb).to be_a(Hash)
      expect(rgb.keys).to include(:r, :g, :b)
      expect(rgb[:r]).to eq(188)
      expect(rgb[:g]).to eq(97)
      expect(rgb[:b]).to eq(78)
      puts "#{subject} => #{subject.to_rgb}"
    end
  end
end


# from_int method has been defined in config/initializers/colour.rb
RSpec.describe Color::RGB do

  describe '#from_i' do

    it { expect(Color::RGB).to respond_to :from_i }

    it 'should create a Color from an integer value' do
      int = 12345678
      rgb = int.to_rgb
      color = Color::RGB.from_i(int)
      expect(color).not_to be_nil
      expect(color.red).to   eq(rgb[:r])
      expect(color.green).to eq(rgb[:g])
      expect(color.blue).to  eq(rgb[:b])
    end
  end

  describe '#to_i' do
    subject { Color::RGB.new(188, 97, 78) }

    it { is_expected.to respond_to :to_i }

    it 'Should calculate the integer value of the color' do
      expect(subject.to_i).to eq(12345678)
      puts "Color [R:#{subject.red.to_i}, G:#{subject.green.to_i}, B:#{subject.blue.to_i}] integer value is: #{subject.to_i}"
    end
  end
end
