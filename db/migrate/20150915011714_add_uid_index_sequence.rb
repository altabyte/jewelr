# Important!
# BEFORE running this migration you will need to change schema dump format
# from Ruby to SQL as sequences cannot be represented in Ruby.
# In config/application.rb
#   config.active_record.schema_format = :sql

require_relative 'migration_helper'

class AddUidIndexSequence < ActiveRecord::Migration
  include MigrationHelper

  # Display a list of sequences in PostgreSQL
  #  SELECT * FROM pg_class WHERE relkind='S';

  def up
    if is_postgres?
      say 'Creating sequence for UIDs indexes starting at 0'
      execute "CREATE SEQUENCE #{db_sequence_name};"
      execute "SELECT nextval('#{db_sequence_name}')"
    end
  end

  def down
    if is_postgres?
      say 'Dropping sequence for UIDs indexes'
      execute "DROP SEQUENCE IF EXISTS #{db_sequence_name};"
    end
  end

  #---------------------------------------------------------------------------
  private

  # Get the database sequence name.
  # If the database is set to :redis, briefly set to :postgres
  # to retrieve the sequence name, then restore to :redis.
  #
  # @return [String] the database sequence name
  #
  def db_sequence_name
    unless @sequence_name
      is_redis = Rails.configuration.uid.redis?
      Rails.configuration.uid.index_source = :postgres if is_redis
      @sequence_name = Rails.configuration.uid.sequence_name
      Rails.configuration.uid.index_source = :redis if is_redis
    end
    @sequence_name
  end
end
