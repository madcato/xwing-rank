require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  test "order must exists" do
    tourney = tourneys(:tourneyOne)
    round = tourney.rounds.new
    assert round.save, "Round must be saved"
  end
end
