module UidValues

  def current_uid_index
    uid_sequence_name = Rails.configuration.uid.sequence_name
    if Rails.configuration.uid.redis?
      ($redis.get(uid_sequence_name) || 1).to_i
    else
      ActiveRecord::Base.connection.select_value("SELECT last_value FROM #{uid_sequence_name}").to_i
    end
  end
end
