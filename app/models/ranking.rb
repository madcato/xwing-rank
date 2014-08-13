class Ranking < ActiveRecord::Base
  belongs_to :player
  belongs_to :tourney
  
  default_scope { order('points DESC,breakpoints DESC,sos DESC') }

end
