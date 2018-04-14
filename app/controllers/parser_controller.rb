class ParserController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def surfingbird
    page = Nokogiri::HTML(open('https://surfingbird.ru/'))

    page.css('a.exchange-feed-item').each do |link|
      title = link.at_css('div.exchange-feed-item__title').text
      url = link['href']
      body = surfingbird_body_parser(url)

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
    page = Nokogiri::HTML(open('http://www.unn.com.ua/'))

    page.css('div.b-news-feed').each do |link|
      title = link.at_css('a').text
      url = link.at_css('a')['href']
      body = unn_body_parser(url)

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
    page = Nokogiri::HTML(open('http://articles-online.ru/'))

    page.css('div.story').each do |div|
      title = div.css('h2.dtitle a').text
      url = div.css('a')[0]['href']
      body = articles_online_body_parser(url)

      ThirdArticle.create(site: url, title: title, body: body)
    end

    redirect_to articles_online_path
  end

  def articles_online_body_parser(url)
    page = Nokogiri::HTML(open("#{url}"))

    body = page.css('div.nfull').text
  end

  def tnw
    page = Nokogiri::HTML(open('https://thenextweb.com/section/insights/'))

    page.css('div.story-text').each do |div|
      title = div.css('h4.story-title').text
      url = div.css('h4.story-title a')[0]['href']
      body = tnw_body_parser(url)

      TnwArticle.create(site: url, title: title, body: body)
    end

    redirect_to tnw_path
  end

  def tnw_body_parser(url)
    page = Nokogiri::HTML(open("#{url}"))

    body = page.css('div.post-body').text
  end
end
