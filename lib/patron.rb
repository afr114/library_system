class Patron
  attr_reader(:name, :phone, :id, :books_id)

  define_method(:initialize) do |attr|
    @name = attr.fetch(:name)
    @phone = attr.fetch(:phone)
    @id = attr.fetch(:id, nil)
    # @books_id = attr.fetch(:books_id)
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
    @name = attr.fetch(:name, @name)
    @phone = attr.fetch(:phone, @phone)
    # @id = self.id()
    if @name != "" && @phone != ""
      DB.exec("UPDATE patrons SET name = '#{@name}', phone = '#{@phone}' WHERE id = #{self.id()};")
    elsif @phone != ""
      DB.exec("UPDATE patrons SET phone = '#{@phone}' WHERE id = #{self.id()};")
    else
      DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id()};")
    end

    attr.fetch(:books_id, []).each() do |book_id|
      DB.exec("INSERT INTO books_patrons (books_id, patrons_id) VALUES (#{book_id}, #{self.id()});")
    end
  end

  define_method(:books) do
    patron_books = []
    results = DB.exec("SELECT books_id FROM books_patrons WHERE patrons_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch('books_id').to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author = book.first().fetch("author")
      patron_books.push(Book.new({:title => title, :author => author, :id => books_id}))
    end
    patron_books
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  def self.find(id)
    found_patron = nil
    Patron.all().each() do |patron|
      if patron.id().==(id)
        found_patron = patron
      end
    end
    found_patron
  end


end # ends class
