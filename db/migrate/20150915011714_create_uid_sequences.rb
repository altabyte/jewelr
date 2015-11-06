# Important!
# BEFORE running this migration you will need to change schema dump format
# from Ruby to SQL as sequences cannot be represented in Ruby.
# In config/application.rb
#   config.active_record.schema_format = :sql

require_relative 'migration_helper'

class CreateUidSequences < ActiveRecord::Migration
  include MigrationHelper

  # To display a list of sequences in PostgreSQL
  #
  #  SELECT * FROM pg_class WHERE relkind='S';

  def up
    if is_postgres?
      say 'Creating 7-digit sequence for UIDs, starting at 1'
      execute "CREATE SEQUENCE #{db_sequence_name(7)};"
      execute "SELECT nextval('#{db_sequence_name(7)}')" # Increment to mimic Redis sequences, which always start at 1.

      say 'Creating 9-digit sequence for UIDs, starting at 1'
      execute "CREATE SEQUENCE #{db_sequence_name(9)};"
      execute "SELECT nextval('#{db_sequence_name(9)}')" # Increment to mimic Redis sequences, which always start at 1.
    end
  end

  def down
    if is_postgres?
      say 'Dropping 9-digit UID sequence'
      execute "DROP SEQUENCE IF EXISTS #{db_sequence_name(9)};"

      say 'Dropping 7-digit UID sequence'
      execute "DROP SEQUENCE IF EXISTS #{db_sequence_name(7)};"
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
  def db_sequence_name(digits)
    sequence_name = nil
    is_redis = UID.configuration.redis?
    UID.configuration.index_source = :postgres if is_redis
    sequence_name = UID.configuration.sequence_7_name if digits == 7
    sequence_name = UID.configuration.sequence_9_name if digits == 9
    UID.configuration.index_source = :redis if is_redis
    sequence_name
  end
end
