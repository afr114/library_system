class Book
  attr_reader(:title)

  define_method(:initialize) do |attr|
    @title = attr.fetch(:title)
  end
end # ends class
