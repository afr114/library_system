require('spec_helper')

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

  describe('#save') do
    it ('lets you save to the database') do
      test_book = Book.new({:title => "Harry Potter and the muggle mortgage crisis", :author => "J.K. Meowling", :id => 1})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end
end #end spec
