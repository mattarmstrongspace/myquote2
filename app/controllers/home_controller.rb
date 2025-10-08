class HomeController < ApplicationController
  def index
    @quotes = Quote.includes(:author, :categories).take(10)
  end
end
