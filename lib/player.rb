class Player
  attr_accessor :name, :life_points

  def initialize(player)
    @name = player
    @life_points = 10
  end

  def show_state
    life_symbol = "❤️ " * @life_points
    print "#{@name} a #{@life_points} points de vie. #{life_symbol} "
  end

  def attacks(player_under_attack)
    print "#{self.name} attaque #{player_under_attack.name} 🗡️ "
    damage_done = compute_damage
    player_under_attack.gets_damage(damage_done)
    puts " Il lui inflige #{damage_done} points de dommages.\n"
    if player_under_attack.life_points <= 0
      puts "💀 Le joueur #{player_under_attack.name} a été tué! 💀"
    elsif self.life_points <= 0
      puts "💀 Le joueur #{self.name} a été tué! 💀"
    end
  end

  def gets_damage(hit)
    self.life_points -= hit
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(player)
    @name = player
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon = rand(1..6)
    if new_weapon <= 2
      puts "Tu as trouvé une arme de niveau #{new_weapon} : 🔧"
    elsif new_weapon >= 5
      puts "Tu as trouvé une arme de niveau #{new_weapon} : 🔫"
    else
      puts "Tu as trouvé une arme de niveau #{new_weapon} : 🔪"
    end
    if new_weapon > @weapon_level
      @weapon_level = new_weapon
      puts "Tu utilises maintenant une arme de niveau #{@weapon_level}"
    else
      puts "Plus de chance la prochaine fois... 🙃"
    end
  end

  def search_health_pack
    health_pack = rand(1..6)
    puts "\tRecherche en cours... 🔎"
    case health_pack
    when 1
      puts "Nada. 🤕"
    when (2..5)
      add_life(50)
      puts "Super un peu d'energie. 🍵  +50hp"
    when 6
      add_life(80)
      puts "C'est ma tournée! 🍺  +80hp"
    end
  end

  def add_life(life)
    @life_points += life
    @life_points = 100 if @life_points > 100 #passe à 100 si plus de 100hp.
  end
end
