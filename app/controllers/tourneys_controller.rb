class TourneysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tourney, only: [:show, :edit, :update, :destroy]
  
  # GET /tourneys
  # GET /tourneys.json
  def index
    @tourneys = current_user.tourneys.all
  end

  # GET /tourneys/1
  # GET /tourneys/1.json
  def show
  end

  # GET /tourneys/new
  def new
    @tourney = current_user.tourneys.new
  end

  # GET /tourneys/1/edit
  def edit
  end

  # POST /tourneys
  # POST /tourneys.json
  def create
    @tourney = current_user.tourneys.new(tourney_params)

    respond_to do |format|
      if @tourney.save
        format.html { redirect_to @tourney, notice: 'Tourney was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tourney }
      else
        format.html { render action: 'new' }
        format.json { render json: @tourney.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tourneys/1
  # PATCH/PUT /tourneys/1.json
  def update
    respond_to do |format|
      if @tourney.update(tourney_params)
        format.html { redirect_to @tourney, notice: 'Tourney was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tourney.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tourneys/1
  # DELETE /tourneys/1.json
  def destroy
    @tourney.destroy
    respond_to do |format|
      format.html { redirect_to tourneys_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tourney
      @tourney = current_user.tourneys.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tourney_params
      params.require(:tourney).permit(:state, :titulo)
    end
end
