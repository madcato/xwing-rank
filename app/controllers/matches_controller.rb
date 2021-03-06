class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_parents, :setTab
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = @round.matches
    @selectedRound = @round
    render "rounds/index"
  end
  
  # GET /matches/new
  def new
    @match = @round.matches.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = @round.matches.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to tourney_round_matches_path(@tourney, @round), notice: t('matchCreated') }
        format.json { render action: 'show', status: :created, location: @match }
      else
        format.html { render action: 'new' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    @math = @round.matches.find(params[:id])

    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to tourney_round_matches_path(@tourney, @round), notice: t('matchUpdated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match = @round.matches.find(params[:id])
    @match.destroy
    respond_to do |format|
      format.html { redirect_to tourney_round_matches_path(@tourney, @round) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    def setTab
      setActiveTab(:rounds)
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:player1_id, :player2_id, :points1, :points2, :round_id)
    end

    def load_parents
      @tourney = current_user.tourneys.find(params[:tourney_id]) 
      @round = @tourney.rounds.find(params[:round_id])
    end
end
