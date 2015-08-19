require ('rspec')
require('book')

describe(Book) do
  describe('#title') do
    it("returns the title of the book") do
      test_book = Book.new({:title => "Harry Potter and the muggle mortgage crisis"})
      expect(test_book.title()).to(eq("Harry Potter and the muggle mortgage crisis"))
    end
  end
end #end spec
