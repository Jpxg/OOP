require "bundler"
Bundler.require

require_relative "lib/player"

user = HumanPlayer.new("Nico")
player1 = Player.new("Mario")
player2 = Player.new("Luigi")
enemies = [player1, player2]

def action_menu(enemies)
  possible_choices = ["a", "s"]
  enemies.each_with_index do |enemy, index|
    possible_choices << index.to_s if enemy.life_points > 0
  end

  puts "\n\tQuelle action veux-tu effectuer?\n"
  puts "a - Chercher une meilleur arme 🔨"
  puts "s - Chercher du soin 🤕"
  puts "\n\t Attaquer un joueur en vue ⚔️"
  enemies.each_with_index do |enemy, index|
    print "#{index} - " if enemy.life_points > 0
    puts "#{enemy.show_state}" if enemy.life_points > 0
  end
  begin
    print "> "
    choice = gets.chomp.to_s
  end while !possible_choices.include?(choice) || choice.length > 1
  return choice
end

begin
  puts "\n\n"
  puts "🏁 Passons à la phase d'attaque: 🏁 \n"
  user.show_state
  user_choice = action_menu(enemies)
  case user_choice
  when "a" then user.search_weapon
  when "s" then user.search_health_pack
  else
    user.attacks(enemies[user_choice.to_i])
  end
  if player1.life_points > 0 || player2.life_points > 0
    puts "Tu es attaqué par les autres joueurs ! 🚁\n\n"
  else
  end
  enemies.each { |enemy| enemy.attacks(user) if user.life_points > 0 && enemy.life_points > 0 }
end while ((player1.life_points > 0 || player2.life_points > 0) && user.life_points > 0)

puts "La partie est terminée. 🏁"
if user.life_points > 0
  puts "Victoire! ✌️ ✌️"
else
  puts "Try again! 😶 😶"
end

#binding.pry