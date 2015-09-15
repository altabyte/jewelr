module UID
  module Sequence

    def current_uid_index
      uid_sequence_name = UID.configuration.sequence_name
      if UID.configuration.redis?
        ($redis.get(uid_sequence_name) || 1).to_i
      else
        ActiveRecord::Base.connection.select_value("SELECT last_value FROM #{uid_sequence_name}").to_i
      end
    end
  end
end
