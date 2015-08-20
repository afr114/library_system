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

describe('adding a new patron', {:type => :feature}) do
  it('allows a patron to sign up to checkout books') do
    visit('/patrons')
    click_link('Click here to sign up for the Library and begin checking out these books!')
    fill_in('name', :with => 'Dick Grayson')
    fill_in('phone', :with => '2127205678')
    click_button('Sign Up!')
    expect(page).to have_content('Congratulations! Welcome to the Library.  You can now check out books.')
  end
end
