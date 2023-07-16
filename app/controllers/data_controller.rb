require 'net/http'
require 'json'
require 'rexml/document'

class DataController < ApplicationController
  def index
    @thehill_items = fetch_feed_items('https://thehill.com/homenews/feed/')
    @foxbusiness_items = fetch_feed_items('https://moxie.foxbusiness.com/google-publisher/latest.xml')
  end

  private

  def fetch_feed_items(feed_url)
    xml_data = Net::HTTP.get(URI.parse(feed_url))
    doc = REXML::Document.new(xml_data)
    items = []
    doc.elements.each('rss/channel/item') do |item|
      item_data = {
        title: item.elements['title'].text,
        description: item.elements['description'].text,
        link: extract_link(item),
        pub_date: item.elements['pubDate'].text,
        image_url: extract_image_url(item)
      }
      items << item_data
    end
    items
  end
  #Check for <link> or <guid>
  def extract_link(item)
    item.elements['link']&.text || item.elements['guid']&.text
  end
  
  def extract_image_url(item)
    image_url = item.elements['image']&.attributes&.fetch('url', nil)
    image_url ||= item.elements['enclosure']&.attributes&.fetch('url', nil)
    image_url ||= item.elements['media:content']&.attributes&.fetch('url', nil)
    image_url
  end
  
  
end