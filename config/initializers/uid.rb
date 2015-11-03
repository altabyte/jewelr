module UID

  class << self
    def configuration
      @options ||= UidOptions.new
    end
  end

  UidOptions = Struct.new(:sequence_source, :sequence_name, :seed, :path, :file_prefix, :file_extension, :digits, :per_file) do

    def sequence_source=(source)
      raise 'UID sequence source must be either :redis or :postgres' unless [:redis, :postgres].include?(source)
      @sequence_source = source
    end

    def sequence_source
      @sequence_source ||= :postgres
    end

    def redis?
      @sequence_source == :redis
    end

    def postgres?
      !redis?
    end
  end
end

UID.configuration.sequence_source  = :postgres
UID.configuration.sequence_name    = 'UID_Sequence_Index'
UID.configuration.digits           = 7
UID.configuration.per_file         = 100_000
UID.configuration.path             = Rails.root.join('config/uids')
UID.configuration.file_prefix      = "uids_#{UID.configuration.digits}_"
UID.configuration.file_extension   = '.txt'
UID.configuration.seed             = ENV['UID_GENERATOR_SEED'].to_i
