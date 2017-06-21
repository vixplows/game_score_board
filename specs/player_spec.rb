require 'minitest/autorun'
require 'minitest/rg'

require_relative '../models/player'

class TestPlater < Minitest::Test
  def setup
    @player1 = Player.new("Wa Wa")
    @player2 = Player.new("Pa Pa")
    @player3 = Player.new("La La")
  end

  def test_message__winner
    assert_equal("What a winner!", @player1.message())
  end

  def test_message__loser
    assert_equal("What a player!", @player2.message())
  end

  def test_message__player
    assert_equal("What a loser!",@player3.message())
  end

end