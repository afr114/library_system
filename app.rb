require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
also_reload('lib/**/*.rb')
require('pg')
require('pry')
require('launchy')

DB = PG.connect({:dbname => "library_system_test"})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/books_form') do
  erb(:books_form)
end

post('/books') do
  book = Book.new({:title => params.fetch("title"), :author => params.fetch("author")})
  book.save()
  redirect('/books')
end

get('/book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:book)
end

patch("/book/:id") do
  title = params.fetch("title")
  author = params.fetch("author")
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author})
  redirect('/books')
end

delete('/book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  # @books = Book.all()
  redirect('/books')
end

get('/patrons') do
  @books = Book.all()
  erb(:patrons)
end

get('/patrons_form') do
  erb(:patrons_form)
end

post('/patrons') do
  patron = Patron.new({:name => params.fetch("name"), :phone => params.fetch("phone")})
  patron.save()
  redirect('/patrons')
end

get('/checkout/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:checkout)
end
