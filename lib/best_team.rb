class BestTeam
  N = 4

  attr_accessor(:divisions,
                :g_players,
                :lw_players,
                :rw_players,
                :c_players,
                :ld_players,
                :rd_players
                )

  def initialize(params)
    @players = Player.where(nation: params[:nation])
    @teams_id = []
    @divisions = []
    @pos_replacement_rules = {
      lw: ['C', 'RW'],
      c: [['LW', 'RW']],
      rw: ['C', 'LW'],
      ld: ['RD'],
      rd: ['LD'],
      g: []
    }

    perfom
  end

  def perfom
    find_players
    create_divisions
  end

  private

  def create_divisions
    N.times do |i|
      @divisions[i] = { LW: @lw_players[i],
                        C: @c_players[i],
                        RW: @rw_players[i],
                        LD: @ld_players[i],
                        RD: @rd_players[i]
                      }
    end
  end

  def find_players
    @pos_replacement_rules.each do |pos, replacements|
      count = pos_count(pos)
      instance_variable_set("@#{pos}_players", take_players(pos.to_s.upcase, count))
      players = instance_variable_get("@#{pos}_players")

      replacements.each do |replacement_pos|
        if players.count < count
          find_from_another_pos(replacement_pos,
                                players.count,
                                players).each { |p| players << p }
        end
      end

      update_teams_id(players)

      while players.count < count
        players.push('-')
      end
    end
  end

  def pos_count(pos)
    pos == :g ? 2 : 4
  end

  # функция подбора игрока с другой позиции
  def find_from_another_pos(pos, count, players)
    @players.where(position: pos).where('capacity > 0').order(capacity: :desc)
                                 .offset(N)
                                 .limit(N-count)
                                 .to_a
  end

  # функция подбора игроков с родной позицией
  def take_players(pos, count)
    @players.where(position: pos).where.not(id: @teams_id)
                                 .order(capacity: :desc)
                                 .limit(count).to_a
  end

  # вносим ids уже выбранных игроков, чтобы не взять их опять
  def update_teams_id(players)
    players.each { |player| @teams_id << player.id }
  end
end
