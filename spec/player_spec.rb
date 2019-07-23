require_relative '../lib/player'

RSpec.describe HumanPlayer do
    human = HumanPlayer.new("test")
  
    describe "the show state method" do
      it "should show the name, life points and weapon level of the player" do
        expect(human.show_state).to eq ("test a 100 points de vie et une arme de niveau 1")
      end
    end
  
    describe "the add_life method" do
      it "should add life to the player" do
        human.life_points = 50
        human.add_life(40)
        expect(human.life_points).to eq(90) 
      end
      it "should add no more than 100pts" do
        human.add_life(140)
        expect(human.life_points).to eq(100) 
        
      end
    end
  end