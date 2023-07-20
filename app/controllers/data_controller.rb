require 'net/http'
require 'json'
require 'rexml/document'
require 'nokogiri'

class DataController < ApplicationController
  def index
    @thehill_items = fetch_feed_items('https://thehill.com/homenews/feed/')
    @foxbusiness_items = fetch_feed_items('https://moxie.foxbusiness.com/google-publisher/latest.xml')
    @epochtimes_items = fetch_feed_items('https://www.theepochtimes.com/c-us/feed')
    @nyt_items = fetch_feed_items('https://rss.nytimes.com/services/xml/rss/nyt/World.xml')
    @theintercept_items = fetch_feed_items('https://theintercept.com/feed/?lang=en')
    @dailymail_items = fetch_feed_items('https://www.dailymail.co.uk/news/worldnews/index.rss')
    @infowars_items = fetch_feed_items('https://www.infowars.com/rss.xml')
    @thedispatch_items = fetch_feed_items('https://thedispatch.com/feed/')
    @reuters_items = fetch_feed_items('https://www.reutersagency.com/feed/?taxonomy=best-topics&post_type=best')
    @democracynow_items = fetch_feed_items('https://www.democracynow.org/democracynow.rss')
    @dailybeast_items = fetch_feed_items('https://feeds.thedailybeast.com/rss/articles')
    @axios_items = fetch_feed_items('https://api.axios.com/feed/')
    @newyorker_items = fetch_feed_items('https://www.newyorker.com/feed/news')
  end

  private

  def fetch_feed_items(feed_url)
    xml_data = Net::HTTP.get(URI.parse(feed_url))
    doc = REXML::Document.new(xml_data)
    items = []
    doc.elements.each('rss/channel/item') do |item|
      channel = doc.elements['rss/channel']
      channel_image_url = extract_channel_image_url(channel)
      item_data = {
        title: item.elements['title'].text,
        link: extract_link(item),
        image_url: extract_image_url(item),
        channel_image_url: channel_image_url
      }
      items << item_data
    end
    items
  end

  def extract_link(item)
    item.elements['link']&.text || item.elements['guid']&.text
  end

  def extract_image_url(item)
    image_url = item.elements['image']&.attributes&.fetch('url', nil)
    image_url ||= item.elements['enclosure']&.attributes&.fetch('url', nil)
    image_url ||= item.elements['media:content']&.attributes&.fetch('url', nil)
    image_url ||= item.elements['media:group/media:content[@medium="image"]']&.attributes&.fetch('url', nil)
    image_url ||= begin
      content_encoded = item.elements['content:encoded']&.text
      if content_encoded
        doc = Nokogiri::HTML(content_encoded)
        img_tag = doc.at_css('img')
        img_tag['src'] if img_tag
      end
    end
    image_url
  end

  def extract_channel_image_url(channel)
    if channel.elements['title'].text == "US News | The Epoch Times"
      '/assets/epoch-times.jpg'
    elsif channel.elements['title'].text == "NYT > World News"
      '/assets/nyt.jpg'
    elsif channel.elements['title'].text == "The Intercept"
      '/assets/theintercept.png'
    elsif channel.elements['image']
      channel.elements['image/url'].text
    elsif channel.elements['title'].text == "Axios"
      '/assets/axios.png'
    elsif channel.elements['title'].text == "News, Politics, Opinion, Commentary, and Analysis"
      '/assets/newyorker.jpg'
    else
      # Use the default fallback image URL
      '/assets/default-channel-image.jpg'
    end
  end
end


