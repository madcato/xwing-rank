class PlayersTourneysController < ApplicationController
  # before_action :authenticate_user!
#   before_action :set_players_tourney, only: [:show, :edit, :update, :destroy]
#
#   # GET /players_tourneys
#   # GET /players_tourneys.json
#   def index
#     @players_tourneys = PlayersTourney.all
#   end
#
#   # GET /players_tourneys/1
#   # GET /players_tourneys/1.json
#   def show
#   end
#
#   # GET /players_tourneys/new
#   def new
#     @players_tourney = PlayersTourney.new
#   end
#
#   # GET /players_tourneys/1/edit
#   def edit
#   end
#
#   # POST /players_tourneys
#   # POST /players_tourneys.json
#   def create
#     @players_tourney = PlayersTourney.new(players_tourney_params)
#
#     respond_to do |format|
#       if @players_tourney.save
#         format.html { redirect_to @players_tourney, notice: 'Players tourney was successfully created.' }
#         format.json { render action: 'show', status: :created, location: @players_tourney }
#       else
#         format.html { render action: 'new' }
#         format.json { render json: @players_tourney.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /players_tourneys/1
#   # PATCH/PUT /players_tourneys/1.json
#   def update
#     respond_to do |format|
#       if @players_tourney.update(players_tourney_params)
#         format.html { redirect_to @players_tourney, notice: 'Players tourney was successfully updated.' }
#         format.json { render action: 'show', status: :ok, location: @players_tourney }
#       else
#         format.html { render action: 'edit' }
#         format.json { render json: @players_tourney.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /players_tourneys/1
#   # DELETE /players_tourneys/1.json
#   def destroy
#     @players_tourney.destroy
#     respond_to do |format|
#       format.html { redirect_to players_tourneys_url }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_players_tourney
#       @players_tourney = PlayersTourney.find(params[:id])
#     end
#
#     # Never trust parameters from the scary internet, only allow the white list through.
#     def players_tourney_params
#       params.require(:players_tourney).permit(:player_id, :tourney_id)
#     end
end
