module Jewelr
  class UidOptions < ActiveSupport::OrderedOptions

    def index_source=(source)
      raise 'UID index source must be either :redis or :postgres' unless [:redis, :postgres].include?(source)
      @index_source = source
    end

    def redis?
      @index_source == :redis
    end

    def postgres?
      !redis?
    end

    # Get the database sequence name/key.
    # When using Redis the same database will be used by all environments.
    # So, to prevent the Production value from being affected by either the development or
    # test environments this method will postfix the key name with '__DEV' or '__TEST'.
    def sequence_name
      key = 'UID_Sequence_Index'.freeze
      if redis?
        key = "#{key}__TEST" if Rails.env.test?
        key = "#{key}__DEV"  if Rails.env.development?
        key = "Jewelr__#{key}"
      end
      key.freeze
    end
  end
end
