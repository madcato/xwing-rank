class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def simple
    @player = Player.new
  end
 
  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /
  def list
    if params[:city].nil?
      @players = Player.all.order('ranking DESC')
    else
      @players = Player.where(city: params[:city]).order('ranking DESC')
    end
    @selectedCity = params[:city] unless params[:city].nil?
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
    @tourney_id = params[:tourney_id]
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    
    respond_to do |format|
      if @player.save
        if params[:tourney_id].nil? or params[:tourney_id] == ""
          format.html { redirect_to players_url, notice: t('playerCreated') }
          format.json { render action: 'show', status: :created, location: @player }
        else
          format.html { redirect_to tourney_newPlayer_path(params[:tourney_id],player_id: @player), notice: 'Player was successfully created.' }
          format.json { render action: 'show', status: :created, location: @player }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to players_url, notice: t('playerUpdated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to players_url, alert: t('playerNotDestroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:firstName,:lastName, :email, :city, :ranking)
    end
end
