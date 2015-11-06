require 'uid/sequence'

module UID
  module Reset
    include Sequence

    # Reset a UID sequence index to the specified value.
    #
    # @note **WARNINING** this method should only ever be used in tests or Rake tasks!
    #
    # @param [String] sequence_name the name of the sequence to reset.
    #
    # @param [Fixnum] value the new sequence index value.
    #
    # @return [Array [Fixnum]] a two-element array `[original_value, new_value]`
    #
    def reset(sequence_name, value = 0)
      value = 0 if value.to_i <= 0
      value = 1 if value == 0 && UID.configuration.postgres?

      diff = []
      diff << uid_current_index(sequence_name)

      if UID.configuration.redis?
        $redis.set(sequence_name, value)
      else
        ActiveRecord::Base.connection.select_value("ALTER SEQUENCE #{sequence_name} RESTART WITH #{value};")
      end

      diff << uid_current_index(sequence_name)
      diff
    end
  end
end
