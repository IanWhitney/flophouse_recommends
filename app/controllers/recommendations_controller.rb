class RecommendationsController < ApplicationController
  # GET /recommendations
  # GET /recommendations.json
  def index
    @recommendations = Recommendation.all

    render json: @recommendations
  end

  # GET /recommendations/1
  # GET /recommendations/1.json
  def show
    @recommendation = Recommendation.find(params[:id])

    render json: @recommendation
  end

  # GET /recommendations/new
  # GET /recommendations/new.json
  # def new
  #   @recommendation = Recommendation.new
  # 
  #   render json: @recommendation
  # end

  # POST /recommendations
  # POST /recommendations.json
  # def create
  #   @recommendation = Recommendation.new(params[:recommendation])
  # 
  #   if @recommendation.save
  #     render json: @recommendation, status: :created, location: @recommendation
  #   else
  #     render json: @recommendation.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /recommendations/1
  # PATCH/PUT /recommendations/1.json
  # def update
  #   @recommendation = Recommendation.find(params[:id])
  # 
  #   if @recommendation.update_attributes(params[:recommendation])
  #     head :no_content
  #   else
  #     render json: @recommendation.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /recommendations/1
  # DELETE /recommendations/1.json
  # def destroy
  #   @recommendation = Recommendation.find(params[:id])
  #   @recommendation.destroy
  # 
  #   head :no_content
  # end
end
