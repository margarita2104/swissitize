class CardsController < ApplicationController
  def create
    @card_collection = CardCollection.find(params[:card_collection_id])
    @card = @card_collection.cards.create(card_params)
    redirect_to card_collection_path(@cards_collection)
  end

  private

  def card_params
    params.require(:card).permit(:question, :answer)
  end
end
