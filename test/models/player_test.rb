require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "player name" do
    player = Player.new
    assert_not player.save, "Player saved without a name"
  end
  
  test "player name length" do
    player = Player.new
    player.name = "hola"
    assert_not player.save, "Player saved with a name too short"
  end
end
