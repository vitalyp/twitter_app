namespace :db do
  desc 'Truncate all tables except schema_migrations and import seeds'
  task :truncate => "db:load_config" do
    config = ActiveRecord::Base.configurations['::Rails.env']
    p "App configuration: #{config}"
    ActiveRecord::Base.establish_connection
    # syntax support for SQLite databases:
    truncate_syntax =
      case ActiveRecord::Base.connection.adapter_name
        when 'SQLite'
          then 'DELETE FROM tbl'
        else 'TRUNCATE tbl CASCADE'
      end
    tables = ActiveRecord::Base.connection.tables - ['schema_migrations']
    p 'Truncating tables (except schema_migrations), please wait'
    tables.each do |table|
      ActiveRecord::Base.connection.execute(truncate_syntax.gsub("tbl", table))
      p "[ #{table} ]"
    end
    puts " [ \e[0;32m OK \e[0m ]"
  end
end
