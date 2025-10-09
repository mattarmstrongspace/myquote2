class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:author, :categories).take(10)
  end

  def uquotes
    @quotes = Quote.includes(:author).where(user_id: session[:user_id])
  end

end
