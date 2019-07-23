require_relative "../lib/game"
require_relative "../lib/player"

RSpec.describe Game do
  lets_play = Game.new("test")
  describe "the kill_player(player) method" do
    it "should delete the player from the array" do
      jeu.kill_player(lets_play.enemies[0])
      expect(lets_play.enemies.length).to eq (3)
    end
  end

  describe "the is_still_going_on? method" do
    it "should return true if the player is still alive" do
      expect(lets_play.is_still_going_on?).to eq(true)
      lets_play.human_player.life_points = 0
      expect(lets_play.is_still_going_on?).to eq(false)
    end

    it "should return false if all the enemies are dead" do
      lets_play.human_player.life_points = 1
      expect(lets_play.is_still_going_on?).to eq(true)
      lets_play.enemies = []
      expect(lets_play.is_still_going_on?).to eq(false)
    end
  end
end
