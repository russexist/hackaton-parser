class ArticlesController < ApplicationController
  def surfingbird
    @first_articles = FirstArticle.all
  end

  def unn
    @second_articles = SecondArticle.all
  end

  def articles_online
    @third_articles = ThirdArticle.all
  end

  def tnw
    @tnw_articles = TnwArticle.all
  end
end
