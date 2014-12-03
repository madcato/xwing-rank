class PublicTourneyController < ApplicationController
  
  def index
    publicId = params[:publicId]
    publicId = params[:publicId2] unless params[:publicId2].nil?
    
    @tourney = Tourney.find_by(:publicId => publicId)

    respond_to do |format|
      if @tourney
        format.html {  }
      else
        format.html { redirect_to :root, alert: t('invalidPublicId') }
      end
    end
  end
  
end
