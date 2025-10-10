class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  #ensures that app users cannot access any methods other than index and show, unles validated and logged in.
  before_action :require_login, except: [:index, :show]

  # GET /quotes or /quotes.json
  def index
   #  @quotes = Quote.all
   # ensuring the user can only see and edit their own quotes
   @quotes = current_user.quotes
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    3.times { @quote.categorizations.build} #give the form 3 category fields
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)

    #if no author is selected,but new author fields have data
    if @quote.author_id.blank? && (new_author_params[:auth_fname].present? ||new_author_params[:auth_lname].present?)
      new_author = Author.create(new_author_params)
      @quote.author_id = new_author.id
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      params.require(:quote).permit(:quote, :year, :is_public, :comment, :user_id, :author_id, category_ids: [])
    end

    def new_author_params
      params.require(:new_author).permit(:auth_fname, :auth_lname, :birth_year, :death_year, :is_anon, :bio)
    end
end
