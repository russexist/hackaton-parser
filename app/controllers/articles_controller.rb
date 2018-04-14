class ArticlesController < ApplicationController
  def surfingbird
    @first_articles = FirstArticle.all.paginate(page: params[:page])
  end

  def unn
    @second_articles = SecondArticle.all.paginate(page: params[:page])
  end

  def articles_online
    @third_articles = ThirdArticle.all.paginate(page: params[:page])
  end

  def tnw
    @tnw_articles = TnwArticle.all.paginate(page: params[:page])
  end
end
