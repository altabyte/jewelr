# Add the Hstore extension to PostgreSQL
#
# Important!
# BEFORE running this migration you will need to change schema dump format
# from Ruby to SQL as Hstore cannot be represented in Ruby.
# In config/application.rb
#   config.active_record.schema_format = :sql
#
# To see all _available_ extensions
#   SELECT pg_available_extensions();
#
# To see all _installed_ extensions
#   SELECT * from pg_extension;
#
# http://jes.al/2013/11/using-postgres-hstore-rails4/

require_relative 'migration_helper'

class AddPostgresHstore < ActiveRecord::Migration
  include MigrationHelper

  def up
    if is_postgres?
      puts 'Creating PostgreSQL Hstore extension'
      #execute 'CREATE EXTENSION "hstore"'
      enable_extension 'hstore'
    end
  end

  def down
    if is_postgres?
      puts 'Droppping PostgreSQL Hstore extension'
      #execute 'DROP EXTENSION "hstore"'
      disable_extension 'hstore'
    end
  end

end
