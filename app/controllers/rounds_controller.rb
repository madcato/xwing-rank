class RoundsController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_parent
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = @tourney.rounds
    @rankings =  @tourney.rankings
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
    @round = @tourney.rounds.new
    
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
    @round = @tourney.rounds.find(params[:id])

    respond_to do |format|
      if @round.update(round_params)
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
  
  #GET 
  def removePlayer
    @tourney.players.delete(params[:player_id])
    player = Player.find(params[:player_id])
    @tourney.removePlayerFromRanking(player)
    
    respond_to do |format|
      format.html { redirect_to tourney_rounds_path(@tourney), notice: 'Player was removed from tourney.' }
      format.json { head :no_content }
    end
  end
  
  def newPlayer
    if params[:player_id].nil? or params[:player_id] == ""
      @player = @tourney.players.new
    else
      @player = Player.find(params[:player_id])
    end
  end
  
  def createInscription

    player = Player.find(params[:player][:id])
    @tourney.players << player
  
    @tourney.addPlayerToRanking(player,params[:inscription][:bye])

    respond_to do |format|
      if @tourney.save
        format.html { redirect_to tourney_rounds_path(@tourney), notice: 'Player was successfully inscribed.' }
        format.json { render action: I18n.t('show'), status: :created, location: @tourney }
      else
        format.html { render action: 'newPlayer' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def seedRound
    @round = @tourney.rounds.find(params[:round_id])
    @round.seedRound
    
    respond_to do |format|
      format.html { redirect_to [@tourney, @round], notice: 'Round was successfully updated.' }
      format.json { head :no_content }
    end
  end
  
  def createAndSeedRound
    # check last round is filled completely
    @lastRound = @tourney.lastRound
    if !@lastRound.nil? and !@lastRound.allMatchesFilled?
      respond_to do |format|
        format.html { redirect_to :back, alert: "Last round is not completed" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
      return
    end
    
    @round = @tourney.rounds.new
    
    respond_to do |format|
      if !@round.save
        format.html { render action: 'new' }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      else
        @round.seedRound
        format.html { redirect_to [@tourney, @round], notice: 'Round was successfully updated.' }
        format.json { head :no_content }
      end
    end
  end
  
  def calculateSOS
    @tourney.calculateSOS
    redirect_to action: 'index'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = @tourney.rounds.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:order, :tourney_id, :player)
    end

    
    def load_parent
      @tourney = current_user.tourneys.find(params[:tourney_id]) 
    end
end
