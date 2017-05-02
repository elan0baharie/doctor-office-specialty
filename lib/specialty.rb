class Specialty
  attr_accessor(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def ==(another_specialty)
    (self.id() == another_specialty.id()) && (self.name() == another_specialty.name())
  end

  def self.all
    all_specialties = DB.exec("SELECT * FROM specialties;")
    saved_specialties = []
    all_specialties.each() do |specialty|
      id = specialty.fetch('id').to_i()
      name = specialty.fetch('name')
      saved_specialties.push(Specialty.new({:id => id, :name => name}))
    end
    saved_specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find(id)
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id() == id
      found_specialty = specialty
      end
    end
    found_specialty
  end

  def doctors
    specialty_doctors = []
    doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()}")
    doctors.each() do |doctor|
      name = doctor.fetch('name')
      specialty_name = doctor.fetch('specialty_name')
      specialty_id = doctor.fetch('specialty_id')
      specialty_doctors.push(Doctor.new({:name => name, :specialty_name => specialty_name, :specialty_id => specialty_id}))
    end
    specialty_doctors
  end

end
