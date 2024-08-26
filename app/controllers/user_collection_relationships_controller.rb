class UserCollectionRelationshipsController < ApplicationController
  before_action :set_user_collection_relationship, only: %i[ show edit update destroy ]

  # GET /user_collection_relationships or /user_collection_relationships.json
  def index
    @user_collection_relationships = UserCollectionRelationship.all
  end

  # GET /user_collection_relationships/1 or /user_collection_relationships/1.json
  def show
  end

  # GET /user_collection_relationships/new
  def new
    @user_collection_relationship = UserCollectionRelationship.new
  end

  # GET /user_collection_relationships/1/edit
  def edit
  end

  # POST /user_collection_relationships or /user_collection_relationships.json
  def create
    @user_collection_relationship = UserCollectionRelationship.new(user_collection_relationship_params)

    respond_to do |format|
      if @user_collection_relationship.save
        format.html { redirect_to user_collection_relationship_url(@user_collection_relationship), notice: "User collection relationship was successfully created." }
        format.json { render :show, status: :created, location: @user_collection_relationship }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_collection_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_collection_relationships/1 or /user_collection_relationships/1.json
  def update
    respond_to do |format|
      if @user_collection_relationship.update(user_collection_relationship_params)
        format.html { redirect_to user_collection_relationship_url(@user_collection_relationship), notice: "User collection relationship was successfully updated." }
        format.json { render :show, status: :ok, location: @user_collection_relationship }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_collection_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_collection_relationships/1 or /user_collection_relationships/1.json
  def destroy
    @user_collection_relationship.destroy!

    respond_to do |format|
      format.html { redirect_to user_collection_relationships_url, notice: "User collection relationship was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_collection_relationship
      @user_collection_relationship = UserCollectionRelationship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_collection_relationship_params
      params.fetch(:user_collection_relationship, {})
    end
end
