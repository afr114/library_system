require ('rspec')
require('book')
require('pg')
require('patron')

DB = PG.connect({:dbname => "library_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM patrons *;")
  end
end
