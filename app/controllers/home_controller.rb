class HomeController < ApplicationController
  def index
    #index method loads 10 most recently submitted
    @quotes = Quote.includes(:author, :categories).where(is_public: true).order(created_at: :desc).limit(10)
  end

  def uquotes
    #load quotes submitted by the logged in user
    @quotes = Quote.includes(:author).where(user_id: session[:user_id])
  end

end
