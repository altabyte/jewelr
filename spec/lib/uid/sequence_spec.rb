require 'rails_helper'

require 'uid/reset'
require 'uid/sequence'

describe 'Sequence' do

  let(:sequence) { Class.new { extend UID::Sequence } }
  let(:reset)    { Class.new { extend UID::Reset } }

  # Load the UID index file from the current directory.
  before :all do
    UID.configuration.path = __dir__
  end

  before { reset_sequence_index }

  it 'Responds to method names' do
    expect(sequence).to respond_to :current_uid_index
    expect(sequence).to respond_to :next_uid
    expect(sequence).to respond_to :next_uid_with_index
  end


  describe '#current_uid_index' do
    it { expect(sequence.current_uid_index).to eq(UID.configuration.redis? ? 0 : 1) }

    it 'produces sequential values starting at 1' do
      (1..20).each do |i|
        sequence.next_uid
        expect(sequence.current_uid_index).to eq(i)
      end
    end
  end


  describe '#next_with_index' do

    let(:first_20) { [3845236, 1707934, 7010142, 9880931, 6397540, 1425616, 2716540, 2524184, 4726490, 5904085, 6337563, 6487476, 8703780, 9696303, 2568104, 8101982, 1875896, 7290545, 6496913, 6872586] }

    it '' do
      (1..20).each do |i|
        next_uid_with_index = sequence.next_uid_with_index
        puts "#{UID.configuration.sequence_source}:  #{next_uid_with_index}"
        expect(sequence.current_uid_index).to eq(i)
        expect(next_uid_with_index.index).to eq(i)
        expect(next_uid_with_index.uid).to eq(first_20[i - 1])
      end
    end
  end


  context 'When getting UIDs concurrently' do

    it 'returns sequential UIDs for multiple threads' do
      thread_count = 4  # Must be <= database connection pool size
      loop_count = 100
      threads = []
      uids = []

      (0...thread_count).each do |t|
        threads << Thread.new(t) do
          (0...loop_count).each do
            next_uid_with_index = sequence.next_uid_with_index
            uids << next_uid_with_index
          end
        end
      end

      threads.map(&:join)

      expect(uids.count).to eq(thread_count * loop_count)
      uids.each_with_index do |uid_with_index, i|
        puts uid_with_index
        expect(uid_with_index.index).to eq(i + 1)
      end
    end
  end


  # Helper method to reset the sequence index value.
  def reset_sequence_index(value = 0)
    reset.reset(value)
  end
end
