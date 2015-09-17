require 'uid/sequence'

module UID
  module Reset
    include Sequence

    # Reset the UID sequence index to the specified value.
    #
    # @note **WARNINING** this method should only ever be used in tests or Rake tasks!
    #
    # @param [Fixnum] value the new sequence start value.
    #
    # @return [Array [Fixnum]] a two-element array `[original_value, new_value]`
    #
    def reset(value = 0)
      value = 0 if value.to_i <= 0
      value = 1 if value == 0 && UID.configuration.postgres?

      diff = []
      diff << current_uid_index

      if UID.configuration.redis?
        $redis.set(UID.configuration.sequence_name, value)
      else
        ActiveRecord::Base.connection.select_value("ALTER SEQUENCE #{UID.configuration.sequence_name} RESTART WITH #{value};")
      end

      diff << current_uid_index
      diff
    end
  end
end
