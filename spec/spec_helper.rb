require('pg')
require('rspec')
require('doctor')
require('specialty')
require('pry')
require('patient')

DB = PG.connect({:dbname => 'doctor_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM specialties *;")
  end
end
