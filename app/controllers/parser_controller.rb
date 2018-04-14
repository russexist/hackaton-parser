class ParserController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def surfingbird
    url = 'https://surfingbird.ru/'
    page = Nokogiri::HTML(open(url))

    page.css('a.exchange-feed-item').each do |link|
      title = link.at_css('div.exchange-feed-item__title').text
      body = surfingbird_body_parser(link['href'])

      FirstArticle.create(site: url, title: title, body: body)
    end

    redirect_to surfingbird_path
  end

  def surfingbird_body_parser(url)
    page = Nokogiri::HTML(open("https:#{url}"))

    body = []
    div = page.css('div.b-parser')
    span = div.css('span').text

    body << span if span.length > 100
    body << div.css('div').text
    body << div.css('p').text

    body
  end

  def unn
    url = 'http://www.unn.com.ua/'
    page = Nokogiri::HTML(open(url))

    page.css('div.b-news-feed').each do |link|
      title = link.at_css('a').text
      body = unn_body_parser(link.at_css('a')['href'])

      SecondArticle.create(site: url, title: title, body: body)
    end

    redirect_to unn_path
  end

  def unn_body_parser(url)
    page = Nokogiri::HTML(open("http://www.unn.com.ua#{url}"))

    body = ''
    full = page.css('div.b-news-full')
    full.css('p').each do |p|
    	body += p.text
    end

    body
  end

  def articles_online
    url = 'http://articles-online.ru/'
    page = Nokogiri::HTML(open(url))

    page.css('div.story').each do |div|
      title = div.css('h2.dtitle a').text
      body = articles_online_body_parser(div.css('a')[0]['href'])

      ThirdArticle.create(site: url, title: title, body: body)
    end

    redirect_to articles_online_path
  end

  def articles_online_body_parser(url)
    page = Nokogiri::HTML(open("#{url}"))

    body = page.css('div.nfull').text
  end
end
