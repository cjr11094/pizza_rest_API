require 'sequel'
require 'csv'

# connect to local file database
database = Sequel.postgres('pizzaAnalytics')
# drop the tables if they exist
database.run "DROP TABLE IF EXISTS loader;"
# database.run "drop table persons;"
database.run "DROP TABLE IF EXISTS people CASCADE;"
database.run "DROP TABLE IF EXISTS pizzas;"
# create the loader relation with csv file. this will contain all data, and we can 
database.run "CREATE TABLE loader (name text not null, type text not null, date timestamp not null);"
database.run "COPY loader(name, type, date) FROM '/Users/cjr/pizzaAPI/pizzaAnalytics/data.csv' delimiter ',' CSV HEADER;"
# use loader to create persons table with unique id's
# database.run "create table persons(name text not null);"
database.run "CREATE TABLE people(name text not null);"
# database.run "insert into persons(name) select distinct name from loader;"
database.run "INSERT INTO people(name) SELECT DISTINCT name from loader;"
# database.run "alter table persons add column id serial primary key;"
database.run "ALTER TABLE people ADD COLUMN id serial primary key;"
# use loader to create pizzas table, adding foreign keys
database.run "CREATE TABLE pizzas(name text not null, type text not null, date timestamp not null);"
database.run "INSERT INTO pizzas(name, type, date) SELECT * FROM loader;"
database.run "ALTER TABLE pizzas ADD COLUMN person_id integer;"
database.run "UPDATE pizzas SET person_id = p.id FROM persons p WHERE p.name = pizzas.name"
database.run "ALTER TABLE pizzas ADD COLUMN id serial primary key;"
database.run "ALTER TABLE pizzas ADD FOREIGN KEY (person_id) REFERENCES people(id)"

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
