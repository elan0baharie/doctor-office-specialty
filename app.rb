require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/patient')
require('./lib/doctor')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'doctor_office_test'})

get('/') do
  erb(:index)
end

get('/doctors') do
  @doctors = Doctor.all()
  erb(:doctors)
end

get('/doctors/new') do
  erb(:doctors_form)
end

get("/doctors/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

post("/doctors") do
  name = params.fetch('name')
  specialty_name = params.fetch('specialty')
  new_doctor = Doctor.new({:id => nil, :name => name, :specialty_name => specialty_name})
  new_doctor.save()
  erb(:success)
end

post("/patients") do
  name = params.fetch('name')
  birthdate = params.fetch('birthdate')
  doctor_id = params.fetch('doctor_id').to_i
  @doctor = Doctor.find(doctor_id)
  new_patient = Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id })
  new_patient.save()
  erb(:success)
end
