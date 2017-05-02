class Patient

attr_accessor(:name, :birthdate, :doctor_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  def ==(another_patient)
    (self.name().==(another_patient.name())) && (self.birthdate().==(another_patient.birthdate())) && (self.doctor_id().==(another_patient.doctor_id()))
  end

  def self.all
    all_patients = DB.exec("SELECT * FROM patients;")
    saved_patients = []
    all_patients.each() do |patient|
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      doctor_id = patient.fetch("doctor_id").to_i
      saved_patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    saved_patients
  end

  def save
    DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id});")
  end

  def delete
    DB.exec("DELETE FROM doctors WHERE id= #{self.id()};")
  end
end
