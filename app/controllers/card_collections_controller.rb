class CardCollectionsController < ApplicationController
  before_action :set_card_collection, only: %i[show edit update destroy]

  # GET /card_collections or /card_collections.json
  def index
    @card_collections = CardCollection.all
  end

  # GET /card_collections/1 or /card_collections/1.json
  def show
  end

  # GET /card_collections/new
  def new
    @card_collection = CardCollection.new
    5.times { @card_collection.cards.build }
  end

  # GET /card_collections/1/edit
  def edit
    # 10.times { @card_collection.cards.build }
    @card_collection = CardCollection.find(params[:id])
  end

  # POST /card_collections or /card_collections.json
  def create
    @card_collection = CardCollection.new(card_collection_params)

    respond_to do |format|
      if @card_collection.save
        format.html do
          redirect_to card_collection_url(@card_collection), notice: 'Practice deck was successfully created.'
        end
        format.json { render :show, status: :created, location: @card_collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_collections/1 or /card_collections/1.json
  def update
    respond_to do |format|
      if @card_collection.update(card_collection_params)
        format.html do
          redirect_to card_collection_url(@card_collection), notice: 'Pratice deck was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @card_collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_collections/1 or /card_collections/1.json
  def destroy
    @card_collection.destroy!

    respond_to do |format|
      format.html { redirect_to card_collections_url, notice: 'Pratice deck was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def show_next_card
    card_collection = CardCollection.find(params[:id])
    card = find_card(card_collection, params[:card_id])
    next_card = next_card(card_collection, card)
    prev_card = previous_card(card_collection, card)

    render json: {
      question: next_card.question,
      answer: next_card.answer,
      next_card_id: next_card.id,
      prev_card_id: prev_card.id,
      cardIndex: card_collection.cards.index(next_card) + 1,
      totalCards: card_collection.cards.size
    }
  end

  def show_previous_card
    card_collection = CardCollection.find(params[:id])
    card = find_card(card_collection, params[:card_id])
    prev_card = previous_card(card_collection, card)
    next_card = next_card(card_collection, card)

    render json: {
      question: prev_card.question,
      answer: prev_card.answer,
      next_card_id: next_card.id,
      prev_card_id: prev_card.id,
      cardIndex: card_collection.cards.index(prev_card) + 1,
      totalCards: card_collection.cards.size
    }
  end

  def shuffle_cards
    @card_collection = CardCollection.find(params[:id])
    shuffled_cards = @card_collection.cards.shuffle

    render json: {
      question: shuffled_cards.first.question,
      answer: shuffled_cards.first.answer,
      next_card_id: shuffled_cards.second.id,
      prev_card_id: shuffled_cards.last.id,
      cardIndex: 1,
      totalCards: shuffled_cards.size
    }
  end

  private

  def find_card(card_collection, card_id)
    card_collection.cards.find_by(id: card_id)
  end

  def next_card(card_collection, card)
    card_collection.cards.where('id > ?', card.id).first || card_collection.cards.first
  end

  def previous_card(card_collection, card)
    card_collection.cards.where('id < ?', card.id).last || card_collection.cards.last
  end

  # private

  # Use callbacks to share common setup or constraints between actions.
  def set_card_collection
    @card_collection = CardCollection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_collection_params
    params.require(:card_collection).permit(:name, :description, cards_attributes: %i[id question answer _destroy])
  end
end
