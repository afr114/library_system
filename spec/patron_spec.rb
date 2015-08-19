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
    it ("lets you update patrons in the database") do
      patron = Patron.new({:name => "Hedwig", :phone => "5032228888", :id => nil})
      patron.save()
      patron.update({:name => "Hedwig Smith", :phone => "5032228888"})
      expect(patron.name()).to(eq("Hedwig Smith"))
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
end #end spec
