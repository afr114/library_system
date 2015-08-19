require ('rspec')
require('book')
require('pg')

DB = PG.connect({:dbname => "library_system_test"})

describe(Book) do
  describe('#title') do
    it("returns the title of the book") do
      test_book = Book.new({:title => "Harry Potter and the muggle mortgage crisis", :author => "J.K. Meowling", :id => nil})
      expect(test_book.title()).to(eq("Harry Potter and the muggle mortgage crisis"))
    end
  end

  describe('.all') do
    it ('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end
end #end spec
