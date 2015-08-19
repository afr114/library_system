class Book
  attr_reader(:title, :author, :id)

  define_method(:initialize) do |attr|
    @title = attr.fetch(:title)
    @author = attr.fetch(:author)
    @id = attr.fetch(:id)
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |books|
      title = books.fetch("title")
      id = books.fetch("id").to_i()
      author = books.fetch("author")
      books.push(Book.new({:title => title, :id => id, :author => author}))
    end
    books
  end
end # ends class
