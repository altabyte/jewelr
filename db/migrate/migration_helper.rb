module MigrationHelper

  def is_postgres?
    ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
  end

  def is_mysql?
    ActiveRecord::Base.connection.adapter_name == 'MySQL'
  end

end
