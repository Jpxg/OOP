require "bundler"
Bundler.require

require_relative "lib/player"

player1 = Player.new("Nico")
player2 = Player.new("Pierre")

begin

  puts "    💤 💤 💤 💤 💤 💤\n\n"
  puts "Voici l'etat de chaque joueur :\n"
  player1.show_state
  player2.show_state
  puts "\n    🔔 🔔 🔔 🔔 🔔 🔔\n\n"
  puts "Passons à la phase d'attaque : \n"
  player1.attacks(player2)
  if player2.life_points <= 0
    break
  else
    player2.attacks(player1)
  end
end while player1.life_points > 0 && player2.life_points > 0

#binding.pry