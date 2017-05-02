class Doctor

  attr_accessor(:id, :name, :specialty_name, :specialty_id)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @specialty_name = attributes.fetch(:specialty_name)
    @specialty_id = attributes.fetch(:specialty_id)
  end

  def ==(another_doctor)
    (self.id() == another_doctor.id()) && (self.name() == another_doctor.name()) && (self.specialty_name() == another_doctor.specialty_name()) && (self.specialty_id() == another_doctor.specialty_id())
  end

  def self.all
    all_doctors = DB.exec("SELECT * FROM doctors;")
    saved_doctors = []
    all_doctors.each() do |doctor|
      id = doctor.fetch('id').to_i()
      name = doctor.fetch('name')
      specialty_name = doctor.fetch('specialty_name')
      specialty_id = doctor.fetch('specialty_id')
      saved_doctors.push(Doctor.new({:id => id, :name => name, :specialty_name => specialty_name, :specialty_id => specialty_id}))
    end
    saved_doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty_name, specialty_id) VALUES ('#{@name}', '#{@specialty_name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find(id)
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id() == id
      found_doctor = doctor
      end
    end
    found_doctor
  end

  def patients
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      doctor_id = patient.fetch('doctor_id').to_i()
      doctor_patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    doctor_patients
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @specialty_name = attributes.fetch(:specialty_name)
    @id = self.id()
    DB.exec("UPDATE doctors SET name = '#{@name}', specialty_name = '#{@specialty_name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM doctors WHERE id= #{self.id()};")
    DB.exec("DELETE FROM patients WHERE doctor_id = #{self.id()};")
  end

end
