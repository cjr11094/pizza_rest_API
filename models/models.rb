require 'sequel'
require 'csv'

# connect to local file database
database = Sequel.postgres('pizzaAnalytics')

#
# entity Person
#
class Person < Sequel::Model
end

#
# entity Pizza
#
class Pizza < Sequel::Model
end
