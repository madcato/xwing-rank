class PublicTourneyController < ApplicationController
  
  def index
    @tourney = Tourney.find_by(:publicId => params[:publicId])

    respond_to do |format|
      if @tourney
        format.html {  }
      else
        format.html { redirect_to :root, alert: t('invalidPublicId') }
      end
    end
  end
  
end
