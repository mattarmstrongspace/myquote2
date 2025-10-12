class SearchController < ApplicationController

  # Search quotes by selected category IDs
  def index
    if params[:category_ids].present?

      # Find quotes tagged with any of the selected categories
      @quotematch = Quote.joins(:categories).where(categories: { id: params[:category_ids] }).distinct
    else
      @quotematch = []
    end
  end
end
