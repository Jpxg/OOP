class Game
  attr_accessor :human_player, :enemies

  def initialize(name)
    @players_left = 6
    @human_player = HumanPlayer.new(name)
    @enemies = []
    4.times do |enemy|
      @enemies << Player.new("Enemy#{enemy}")
    end
    @players_index = 0 #ease the new player creation
  end

  def kill_player(index) #clear the board
    @enemies.delete_at(index)
  end

  def insert_players # add new enemies each round
    if is_still_going_on?
      if @enemies.length > @players_left
        puts "Tous les ennemies sont en vue ! 🔭"
      end
      new_players = rand(1..6)
      case new_players
      when 1
        puts "Pas de nouveaux ennemies en vue ! 🔭"
      when (2..4)
        add_enemies(1)
        puts "Un nouveau combattant est en vue! 👹"
      when (5..6)
        add_enemies(2)
        puts "Deux nouveaux combattants sont en vue! 👹 👹"
      end
    end
  end

  def add_enemies(enemies) #shorten the insert_players method
    enemies.times do
      @enemies << Player.new("Enemy#{@players_index}")
      @players_index += 1
      @players_left -= 1
    end
    @enemies
  end

  def is_still_going_on? #true/false
    return @human_player.life_points > 0 && !@enemies.empty?
  end

  def show_player #show the current state of enemies
    @human_player.show_state
    puts "Il y a #{enemies.length} ennemis en vue."
    puts "Il reste #{@players_left + enemies.length} à éliminer."
  end

  def action_menu
    possible_choices = ["a", "s"]
    @enemies.each_with_index do |enemy, index|
      possible_choices << index.to_s if enemy.life_points > 0
    end

    puts "\nQuelle action veux-tu effectuer?\n"
    puts "\ta - Chercher une meilleur arme 🔨"
    puts "\ts - Chercher du soin 🤕"
    puts "Attaquer un joueur en vue ⚔️"
    @enemies.each_with_index do |enemy, index|
      print "\t#{index} - " if enemy.life_points > 0
      puts "#{enemy.show_state}" if enemy.life_points > 0
    end
  end

  def menu_choice(user_choice)
    case user_choice
    when "a" then @human_player.search_weapon
    when "s" then @human_player.search_health_pack
    else
      @human_player.attacks(enemies[user_choice.to_i])
      kill_player(user_choice.to_i) if enemies[user_choice.to_i].life_points <= 0
    end
  end

  def enemies_attack #each enemy is attacking hero
    if is_still_going_on?
      puts "\n\tTu es attaqué par les autres joueurs ! 🚁"
      @enemies.each { |enemy| enemy.attacks(@human_player) if @human_player.life_points > 0 }
    end
  end

  def end_of_game #Win maybe?
    if @enemies.length == 0
      puts "Victoire! ✌️ ✌️"
    elsif @human_player.life_points <= 0
      puts "Try again next time... 😶 😶"
    end
  end
end
