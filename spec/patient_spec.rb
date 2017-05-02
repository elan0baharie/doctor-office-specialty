require('spec_helper')


describe(Patient) do
  describe("#name") do
    it("return the name of the desired patient") do
      test_patient = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => 1})
      expect(test_patient.name()).to(eq("Stu"))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same description") do
      test_patient1 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => 1})
      test_patient2 = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => 1})
      expect(test_patient1).to(eq(test_patient2))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "Stu", :birthdate => "1982-12-12", :doctor_id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end


end
