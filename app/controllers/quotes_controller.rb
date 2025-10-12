class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]
  # Ensures that app users cannot access any methods other than index and show unless validated and logged in.
  before_action :require_login, except: [:index, :show]
  # Ensures that only the correct owner of the quote can edit, update, or destroy their own quotes.
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # GET /quotes
  def index
    # Ensuring the user can only see and edit their own quotes
    @quotes = current_user.quotes
  end

  # GET /quotes/1
  def show
  end

  # GET /quotes/new
  # set a blank quote object and build an empty author for nested form
  def new
    @quote = Quote.new
    @quote.build_author
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # save new quote to database  using submitted form data
  def create
    @quote = Quote.new(quote_params)

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

  # PATCH/PUT /quotes/1
  #allows editing of existing quote using submitted form data
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

  # DELETE /quotes/1
  # delete the quote from the database with success message
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to your_quotes_path, notice: "Quote was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # finds quote by id and assigns it to variable
  def set_quote
    @quote = Quote.find(params[:id])
  end

  # defining which fields are allowed in the form, as well including nested author form if new author is needed to be created
  def quote_params
    permitted = [:quote, :year, :is_public, :comment, :user_id, :author_id, category_ids: []]

    if params[:quote][:author_id].blank?
      permitted << { author_attributes: [:id, :auth_fname, :auth_lname, :birth_year, :death_year, :is_anon, :bio] }
    end

    params.require(:quote).permit(*permitted)
  end

  # Method to ensure that only the quote owner can edit or delete
  def authorize_user
    unless @quote.user == current_user
      redirect_to your_quotes_path, alert: "You are not authorized to edit this quote"
    end
  end
end
