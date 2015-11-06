require 'scatter_swap'

module UID
  module Sequence

    IndexedUID = Struct.new(:index, :uid) do
      def to_s
        "#{index}: #{uid}"
      end
    end

    def uid_current_index(sequence_name)
      if UID.configuration.redis?
        ($redis.get(sequence_name) || 0).to_i
      else
        ActiveRecord::Base.connection.select_value("SELECT last_value FROM #{sequence_name}").to_i
      end
    end

    # Get the next UID value in the sequence.
    # @return [Fixnum] the next UID value.
    def uid_next(sequence_name)
      uid_next_with_index(sequence_name).uid
    end

    # Get the next UID in along with its sequence index.
    # @return [IndexedUID] with index and uid fields.
    def uid_next_with_index(sequence_name)
      if sequence_name == UID.configuration.sequence_7_name
        digits = 7
        seed = UID.configuration.sequence_7_seed
      elsif sequence_name == UID.configuration.sequence_9_name
        digits = 9
        seed = UID.configuration.sequence_9_seed
      else
        raise "Sequence name '#{sequence_name}' is not valid!"
      end

      while (true)
        index = next_index(sequence_name)
        uid = ScatterSwap.hash(index, seed, digits)
        next if uid.to_i <= 10_001

        # Skip UIDs with 4 or more same digits in sequence, eg 1230000, which has 4 '0' in series
        too_many_same_digits = false
        (0..9).each { |i| too_many_same_digits = true and break if uid =~ /[#{i}]{4}/ }
        next if too_many_same_digits

        break # Because no reason not to use this UID
      end
      IndexedUID.new(index, uid)
    end

    #-------------------------------------------------------------------------
    private

    @@next_uid_lock = Mutex.new

    def next_index(sequence_name)
      if UID.configuration.redis?
        $redis.incr(sequence_name)
      else
        ActiveRecord::Base.connection.select_value("SELECT nextval('#{sequence_name}')").to_i
      end
    end
  end
end
