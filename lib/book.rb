class Book
  attr_reader(:title, :author, :id)

  define_method(:initialize) do |attr|
    @title = attr.fetch(:title)
    @author = attr.fetch(:author)
    @id = attr.fetch(:id, nil)
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch("title")
      id = book.fetch("id").to_i()
      author = book.fetch("author")
      books.push(Book.new({:title => title, :id => id, :author => author}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_book)
    self.title().==(another_book.title()).&(self.id().==(another_book.id()))
  end

  def update(attr)
    @title = attr.fetch(:title)
    @author = attr.fetch(:author)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}', author = '#{@author}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

  def self.find(id)
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end


end # ends class
