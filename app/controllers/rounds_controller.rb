class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :edit, :update, :destroy]
  before_filter :load_parent

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = @tourney.rounds.all
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    # @round = Round.find(params[:round])
  end

  # GET /rounds/new
  def new
    @round = @tourney.rounds.new
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = @tourney.rounds.new(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to [@tourney, @round], notice: 'Round was successfully created.' }
        format.json { render action: 'show', status: :created, location: @round }
      else
        format.html { render action: 'new' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @tourney.round.update(round_params)
        format.html { redirect_to [@tourney, @round], notice: 'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = @tourney.rounds.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to tourney_rounds_path(@tourney) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:order, :tourney_id)
    end

    
    def load_parent
      @tourney = Tourney.find(params[:tourney_id]) 
    end
end
