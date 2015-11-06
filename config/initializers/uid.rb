module UID

  class << self
    def configuration
      @options ||= UidOptions.new
    end
  end

  SEQUENCE_7_DIGITS ||= 7.freeze
  SEQUENCE_9_DIGITS ||= 9.freeze

  UidOptions = Struct.new(:sequence_source, :sequence_7_name, :sequence_9_name, :sequence_7_seed, :sequence_9_seed) do
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

UID.configuration.sequence_source = :postgres
UID.configuration.sequence_7_name = 'uid_7_digit_seq'
UID.configuration.sequence_9_name = 'uid_9_digit_seq'
UID.configuration.sequence_7_seed = ENV['UID_SEQUENCE_7_SEED'].to_i
UID.configuration.sequence_9_seed = ENV['UID_SEQUENCE_9_SEED'].to_i
