require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adds a doctor and lands on success page', {:type => :feature}) do
  it('allows a user to see all of the doctors that have been created') do

    visit('/')
    click_link('Add New Doctor')
    fill_in('name', :with => "Elan")
    fill_in('specialty', :with => "cardiology")
    click_button('Add Doctor')
    expect(page).to have_content("You have added a doctor or patient.")
  end
end

describe('views all listed doctors', {:type => :feature}) do
  it('allows a user to see all of the doctors that have been created') do
    test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
    test_doctor.save()
    visit('/')
    click_link('View All Doctors')
    expect(page).to have_content(test_doctor.name)
  end
end

describe('seeing details for a doctor\'s patient list', {:type => :feature}) do
  it('allows a user to click a doctor to see the patients and details for them') do
    test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
    test_doctor.save()
    test_patient = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => test_doctor.id()})
    test_patient.save()
    visit('/doctors')
    click_link(test_doctor.name())
    expect(page).to have_content(test_patient.name())
  end
end
