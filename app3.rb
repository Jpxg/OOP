require "bundler"
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

lets_play = Game.new("Nico")

while lets_play.is_still_going_on?
  puts "\n\t🏁 Passons à la phase d'attaque: 🏁 \n"
  lets_play.show_player
  lets_play.action_menu
  possible_choices = ["a", "s"]
  lets_play.enemies.each_with_index do |enemy, index|
    possible_choices << index.to_s if enemy.life_points > 0
  end
  begin
    print "> "
    choice = gets.chomp.to_s
  end while !possible_choices.include?(choice) || choice.length > 1
  lets_play.menu_choice(choice)
  lets_play.enemies_attack
  begin
    lets_play.insert_players
  end while lets_play.enemies.size == 0
end

lets_play.end_of_game
