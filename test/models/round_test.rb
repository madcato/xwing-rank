require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  test "order must exists" do
    round = Round.new
    assert_not round.save, "Round saved without order field"
  end
end
