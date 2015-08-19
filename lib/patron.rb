class Patron
  attr_reader(:name, :phone, :id)

  define_method(:initialize) do |attr|
    @name = attr.fetch(:name)
    @phone = attr.fetch(:phone)
    @id = attr.fetch(:id)
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id").to_i()
      phone = patron.fetch("phone")
      patrons.push(Patron.new({:name => name, :id => id, :phone => phone}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  def update(attr)
    @name = attr.fetch(:name)
    @phone = attr.fetch(:phone)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}', phone = '#{@phone}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end


end # ends class
