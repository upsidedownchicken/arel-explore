require 'bundler/setup'
require 'arel'
require 'activerecord'

class NoConnection < StandardError; end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

users = Arel::Table.new(:users)
query = users.project(Arel.sql('*'))

begin
  sql = query.to_sql
rescue NoMethodError => error
  if error.message =~ /connection/
    raise NoConnection.new('No database connection')
  else
    raise error
  end
end

puts sql
