module UID
  module Sequence

    @@next_uid_lock = Mutex.new

    IndexedUID = Struct.new(:index, :uid) do
      def to_s
        "#{index}: #{uid}"
      end
    end

    def current_uid_index
      uid_sequence_name = UID.configuration.sequence_name
      if UID.configuration.redis?
        ($redis.get(uid_sequence_name) || 0).to_i
      else
        ActiveRecord::Base.connection.select_value("SELECT last_value FROM #{uid_sequence_name}").to_i
      end
    end

    # Get the next UID value in the sequence.
    # @return [Fixnum] the next UID value.
    def next_uid
      next_uid_with_index.uid
    end

    # Get the next UID in along with its sequence index.
    # @return [IndexedUID] with index and uid fields.
    def next_uid_with_index
      @@next_uid_lock.synchronize do
        index = next_uid_index
        raise 'UID sequence index value could not be determined!' if index < 1
        uid = read_value(index)
        log_uid_sequence_index(index, uid)
        IndexedUID.new(index, uid)
      end
    end


    #-------------------------------------------------------------------------
    private

    def next_uid_index
      if UID.configuration.redis?
        #$redis.set(UID.configuration.sequence_name, 0) unless $redis.exists(UID.configuration.sequence_name)
        $redis.incr(UID.configuration.sequence_name)
      else
        ActiveRecord::Base.connection.select_value("SELECT nextval('#{UID.configuration.sequence_name}')").to_i
      end
    end

    def file_path(file_number)
      Pathname.new("#{UID.configuration.path}/#{UID.configuration.file_prefix}#{file_number.to_s.rjust(2, '0')}#{UID.configuration.file_extension}")
    end

    def read_value(index)
      per_file = UID.configuration.per_file
      uid      = -1

      file_number = (index.to_f / per_file).ceil
      file_path   = "#{file_path(file_number)}"
      return -1 unless File.exist? file_path

      line_number = index
      line_number -= ((file_number - 1) * per_file) if line_number > per_file

      offset = (line_number - 1) * (UID.configuration.digits + 1)  # Add 1 to DIGITS for newline character.
      offset = 0 if offset < 0

      open(file_path, 'r') do |f|
        f.seek(offset)
        uid = f.read UID.configuration.digits
      end
      uid.to_i
    end

    # Log the last used value of UID and it sequence index.
    # Currently this just uses the standard logger.
    # Perhaps need to use a dedicated logger so that it can be checked later?
    def log_uid_sequence_index(index, uid)
      logger.info "UID:  #{uid}  [#{index}]" if defined? logger
    end
  end
end
