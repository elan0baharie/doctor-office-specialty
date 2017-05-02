require('pg')
require('rspec')
require('doctor')
require('pry')
require('patient')

DB = PG.connect({:dbname => 'doctor_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
  end
end
