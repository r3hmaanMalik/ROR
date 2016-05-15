class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.




  def home
require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://www.daraz.pk/')

link = page.link_with(text: 'Random article')

page1 = link.click

puts page1.uri

 
    end
  protect_from_forgery with: :exception
end
