require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/patient')
require('./lib/doctor')
require('./lib/specialty')
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

get('/specialties') do
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  erb(:specialties)
end

get('/specialties/new') do
  erb(:specialties_form)
end

post("/specialties") do
  name = params.fetch('name')
  new_specialty = Specialty.new({:id => nil, :name => name})
  new_specialty.save()
  erb(:success)
end

get("/specialties/:id") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  @specialties = Specialty.all()
  erb(:specialty)
end


get('/doctors/new') do
  erb(:doctors_form)
end

post("/doctors") do
  name = params.fetch('name')
  specialty_name = params.fetch('specialty')
  new_doctor = Doctor.new({:id => nil, :name => name, :specialty_name => specialty_name, :specialty_id => nil})
  new_doctor.save()
  erb(:success)
end

get('/patients/new') do
  @doctors = Doctor.all()
  erb(:patients_form)
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

get("/doctors/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  @doctors = Doctor.all()
  erb(:doctor)
end

get("/doctors/:id/edit") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:edit_doctor)
end



patch("/doctors/:id") do
  name = params.fetch("name")
  specialty_name = params.fetch('specialty')
  @doctor = Doctor.find(params.fetch("id").to_i())
  @doctor.update({:name => name, :specialty_name => specialty_name})
  @doctors = Doctor.all()
  erb(:doctor)
end

delete("/doctors/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i)
  @doctor.delete()
  @doctors = Doctor.all()
  erb(:index)
end
