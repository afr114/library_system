require('spec_helper')

describe(Patron) do
  describe('#name') do
    it("returns the name of the patron") do
      test_patron = Patron.new({:name => "Hedwig", :phone => "5032228888", :id => nil})
      expect(test_patron.name()).to(eq("Hedwig"))
    end
  end

  describe('.all') do
    it ('is empty at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#save') do
    it ('lets you save to the database') do
      test_patron = Patron.new({:name => "Hedwig", :phone => "5032228888", :id => 1})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe('#update') do
    it("lets you update patrons in the database") do
      patron = Patron.new({:name => "Hedwig", :phone => "5032228888", :id => nil})
      patron.save()
      patron.update({:name => "Hedwig Smith", :phone => "5032228888"})
      expect(patron.name()).to(eq("Hedwig Smith"))
    end

    it("lets you add a book to a patron") do
      jose = Patron.new({:name => "Jose Jalapeno", :phone => "3124567896", :id => nil})
      jose.save()
      book1 = Book.new({:title => "The little Jalapeno",:author => "Rico Frederico", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Taco Flavored Kisses", :author => "Jennifer Lopez", :id => nil})
      book2.save()
      jose.update({:books_id => [book1.id(), book2.id()]})
      expect(jose.books()).to(eq([book1, book2]))
    end
  end

  describe("#books") do
    it("returns all the books for a patron") do
      jose = Patron.new({:name => "Jose Jalapeno", :phone => "3124567896", :id => nil})
      jose.save()
      book1 = Book.new({:title => "The little Jalapeno",:author => "Rico Frederico", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Taco Flavored Kisses", :author => "Jennifer Lopez", :id => nil})
      book2.save()
      jose.update({:books_id => [book1.id(), book2.id()]})
      expect(jose.books()).to(eq([book1, book2]))
    end
  end

  describe("#delete") do
    it('deletes a patron from the database') do
      patron = Patron.new({:name => "Hedwig", :phone => "5032228888", :id => nil})
      patron.save()
      patron.delete()
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('returns an animal by its ID') do
      test_patron1 = Patron.new({:name => "Hedwig Smith", :phone => "5038675309", :id => 1})
      test_patron1.save()
      test_patron2 = Patron.new({:name => "Sailor Moon", :phone => "8088675309", :id => 2})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end
end #end spec
