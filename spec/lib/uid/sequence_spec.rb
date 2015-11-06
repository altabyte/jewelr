require 'rails_helper'
require 'uid/reset'
require 'uid/sequence'

describe 'Sequence' do

  let(:sequence_name) { UID.configuration.sequence_7_name }
  let(:sequence) { Class.new { extend UID::Sequence } }
  let(:reset)    { Class.new { extend UID::Reset } }

  before { reset_sequence_index }

  it { expect(sequence_name).not_to be_blank }

  it 'Responds to method names' do
    expect(sequence).to respond_to :uid_current_index
    expect(sequence).to respond_to :uid_next
    expect(sequence).to respond_to :uid_next_with_index
  end

  it { expect(UID.configuration.sequence_7_seed).not_to be_blank }

  describe '#uid_current_index' do
    it { expect(sequence.uid_current_index(sequence_name)).to eq(UID.configuration.redis? ? 0 : 1) }

    it 'produces sequential values starting at 1' do
      (1..20).each do |i|
        sequence.uid_next(sequence_name)
        expect(sequence.uid_current_index(sequence_name)).to eq(i)
      end
    end
  end

  describe '#next_with_index' do

    before do
      @original_seed = UID.configuration.sequence_7_seed
      UID.configuration.sequence_7_seed = 123456789
    end

    after do
      UID.configuration.sequence_7_seed = @original_seed
    end

    let(:first_20) { %w'9823740 7980348 3994870 9840730 3480749 8794350 3897043 0398774 4093871 6897040 4080792 8794080 9084907 0087094 4090874 9850740 9843700 0480779 7940108 8794260' }

    it 'should provide consistent results for a specified seed' do
      (1..20).each do |i|
        next_uid_with_index = sequence.uid_next_with_index(sequence_name)
        puts "#{UID.configuration.sequence_source}:  #{next_uid_with_index}"
        expect(sequence.uid_current_index(sequence_name)).to eq(i)
        expect(next_uid_with_index.index).to eq(i)
        expect(next_uid_with_index.uid).to eq(first_20[i - 1])
      end
    end
  end


  context 'When getting UIDs concurrently' do

    # Seed value ensures no indexes are skipped because 4 or more same sequential digits
    before do
      @original_seed = UID.configuration.sequence_7_seed
      UID.configuration.sequence_7_seed = 12345678
    end

    after do
      UID.configuration.sequence_7_seed = @original_seed
    end

    it 'should not have any duplicates from multiple threads' do
      thread_count = 4  # Must be <= database connection pool size
      loop_count = 250
      threads = []
      uids = []

      (0...thread_count).each do |t|
        threads << Thread.new(t) do
          (0...loop_count).each do
            next_uid_with_index = sequence.uid_next_with_index(sequence_name)
            uids << next_uid_with_index
          end
        end
      end

      threads.map(&:join)

      expect(uids.count).to eq(thread_count * loop_count)
      uids.sort! { |a, b| a.index <=> b.index }
      uids.each_with_index do |uid_with_index, i|
        puts uid_with_index
        expect(uid_with_index.index).to eq(i + 1)
      end

      expect(uids.map { |obj| obj.uid }.sort.uniq.count).to eq(thread_count * loop_count)
    end
  end


  context 'Sequence skips' do

    let(:loop_count) { 10_000 }

    it { expect(UID.configuration.sequence_7_seed).to eq(ENV['UID_SEQUENCE_7_SEED'].to_i) }

    it '' do
      i = 0
      skips = []
      loop_count.times do
        uid = sequence.uid_next_with_index(sequence_name)
        i += 1
        if (uid.index != i)
          while (i < uid.index)
            skips << i
            i += 1
          end
        end
        expect(uid.index).to eq(i)
      end
      puts "Skipped #{skips.count} of #{loop_count} sequence indexes [#{skips.count.to_f / loop_count * 100}%]"
      puts "[#{skips.join(', ')}]"
    end
  end


  #---------------------------------------------------------------------------
  private

  # Helper method to reset the sequence index value.
  def reset_sequence_index(value = 0)
    reset.reset(sequence_name, value)
  end
end
