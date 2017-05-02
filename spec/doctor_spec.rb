require('spec_helper')


describe(Doctor) do
  describe("#name") do
    it("return the name of the desired doctor") do
      test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      expect(test_doctor.name()).to(eq("Elan"))
    end
  end

  describe("#id") do
  it("sets its ID when you save it") do
    test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
    test_doctor.save()
    expect(test_doctor.id()).to(be_an_instance_of(Fixnum))
  end
end

  describe("#==") do
    it("is the same doctor if it has the same description") do
      test_doctor1 = Doctor.new({:id => "nil", :name => "Elan", :specialty_name => "cardiology"})
      test_doctor2 = Doctor.new({:id => "nil", :name => "Elan", :specialty_name => "cardiology"})
      expect(test_doctor1).to(eq(test_doctor2))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a doctor to the array of saved doctors") do
      test_doctor = Doctor.new({:id => "nil", :name => "Elan", :specialty_name => "cardiology"})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that doctor") do
      test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      test_doctor.save()
      test_patient1 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => test_doctor.id()})
      test_patient1.save()
      test_patient2 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => test_doctor.id()})
      test_patient2.save()
      expect(test_doctor.patients()).to(eq([test_patient1, test_patient2]))
    end
  end

  describe("#update") do
    it("lets you update doctors in the database") do
      test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      test_doctor.save()
      test_doctor.update({:name => "Brian", :specialty_name => "cardiology"})
      expect(test_doctor.name()).to(eq("Brian"))
    end
  end

  describe("#delete") do
    it("deletes a doctor's info from the database") do
      test_doctor1 = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      test_doctor1.save()
      test_doctor2 = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      test_doctor2.save()
      test_doctor1.delete()
      expect(Doctor.all()).to(eq([test_doctor2]))
    end
  end

  describe("#delete") do
    it("deletes patients from a doctor's database") do
      test_doctor = Doctor.new({:id => nil, :name => "Elan", :specialty_name => "cardiology"})
      test_doctor.save()
      test_patient1 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => test_doctor.id()})
      test_patient1.save()
      test_patient2 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => test_doctor.id()})
      test_patient2.save()
      test_doctor.delete()
      expect(Patient.all()).to(eq([]))
    end
  end
end
