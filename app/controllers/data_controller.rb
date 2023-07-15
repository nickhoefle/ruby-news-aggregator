require 'net/http'
require 'json'
require 'rexml/document'

class DataController < ApplicationController
  def index
    xml_data = Net::HTTP.get(URI.parse('https://thehill.com/homenews/feed/'))
    doc = REXML::Document.new(xml_data)
    @items = []
    doc.elements.each('rss/channel/item') do |item|
      item_data = {
        title: item.elements['title'].text,
        description: item.elements['description'].text,
        link: item.elements['link'].text,
        pub_date: item.elements['pubDate'].text,
        image_url: item.elements['enclosure'].attributes['url']
      }
      @items << item_data
    end
  end
end
