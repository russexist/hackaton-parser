Rails.application.routes.draw do
  get 'articles/home'

  get 'parser/articles_online'
  get 'parser/surfingbird'
  get 'parser/tnw'
  get 'parser/unn'

  get 'articles_online', to: 'articles#articles_online'
  get 'surfingbird',     to: 'articles#surfingbird'
  get 'tnw',             to: 'articles#tnw'
  get 'unn',             to: 'articles#unn'

  root 'articles#home'
end
