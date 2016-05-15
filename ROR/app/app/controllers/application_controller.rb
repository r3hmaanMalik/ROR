class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 


class Entry
    def initialize(title, link)
      @title = title
      @link = link
    end
    attr_reader :title
    attr_reader :link
  end

  def scrapeDaraz
    require 'open-uri'

    doc = Nokogiri::HTML(open("https://www.daraz.pk/phones/"))

    entries = doc.css('.sku')
   @entriesArray = []
     entries.each do |entry|
    title=entry.css('.brand').text
    link=entry.css('[data-price]').text

          @entriesArray << Entry.new(title, link)
    end	


    render template:'scrapeDaraz'
  end

  protect_from_forgery with: :exception
end
