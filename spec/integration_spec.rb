require('capybara/rspec')
require('launchy')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new book', {:type => :feature}) do
  it('allows a user to view a list of books and a new one') do
    visit('/books')
    click_link('Click here to add a new book')
    fill_in('title', :with => 'The Hobbit')
    fill_in('author', :with => 'J.R.R. Tolkien')
    click_button('Add Book')
    expect(page).to have_content('The Library Employee Page')
  end
end
