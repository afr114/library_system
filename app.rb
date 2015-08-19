require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

DB = PG.connect({:dbname => "library_system"})

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
