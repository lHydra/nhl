class BestTeam

  attr_accessor(:divisions,
                :goalkeepers,
                :left_fwd_players,
                :right_fwd_players,
                :center_players,
                :left_def_players,
                :right_def_players
                )

  def initialize(params)
    @players = Player.where(nation: params[:nation])
    @teams_id = []
    @divisions = []
  end

  def create_best_team
    find_left_forward
    find_center_forward
    find_right_forward
    find_right_defense
    find_left_defense
    find_goalkeeper

    # create divisions array

    4.times do |i|
      @divisions[i] = { LW: @left_fwd_players[i],
                        C: @center_players[i],
                        RW: @right_fwd_players[i],
                        LD: @left_def_players[i],
                        RD: @right_def_players[i]
                      }
    end
  end

  private

  # функция подбора игрока с другой позиции
  def find_from_another_pos(pos, count, players)
    @players.where(position: pos).order(capacity: :desc)
                                 .offset(4)
                                 .take(4-count)
                                 .each { |player| players << player }
  end

  # функция подбора игроков с родной позицией
  def take_players(pos, count)
    @players.where(position: pos).where.not(id: @teams_id)
                                 .order(capacity: :desc)
                                 .take(count)
  end

  # вносим ids уже выбранных игроков, чтобы не взять их опять
  def update_teams_id(players)
    players.each { |player| @teams_id << player.id}
  end

  def find_goalkeeper
    @goalkeepers = take_players('G', 2)

    while @goalkeepers.count < 2
      @goalkeepers.push('-')
    end
  end

  def find_left_forward
    @left_fwd_players = take_players('LW', 4)

    if @left_fwd_players.count < 4
      find_from_another_pos('C', @left_fwd_players.count, @left_fwd_players)
    end

    if @left_fwd_players.count < 4
      find_from_another_pos('RW', @left_fwd_players.count, @left_fwd_players)
    end

    update_teams_id(@left_fwd_players)

    while @left_fwd_players.count < 4
      @left_fwd_players.push('-')
    end
  end

  def find_center_forward
    @center_players = take_players('C', 4)

    if @center_players.count < 4
      find_from_another_pos(['LW', 'RW'], @center_players.count, @center_players)
    end

    update_teams_id(@center_players)

    while @center_players.count < 4
      @center_players.push('-')
    end
  end

  def find_right_forward
    @right_fwd_players = take_players('RW', 4)

    if @right_fwd_players.count < 4
      find_from_another_pos('C', @right_fwd_players.count, @right_fwd_players)
    end

    if @right_fwd_players.count < 4
      find_from_another_pos('LW', @right_fwd_players.count, @right_fwd_players)
    end

    update_teams_id(@right_fwd_players)

    while @right_fwd_players.count < 4
      @right_fwd_players.push('-')
    end
  end

  def find_right_defense
    @right_def_players = take_players('RD', 4)

    if @right_def_players.count < 4
      find_from_another_pos('LD', @right_def_players.count, @right_def_players)
    end

    update_teams_id(@right_def_players)

    while @right_def_players.count < 4
      @right_def_players.push('-')
    end
  end

  def find_left_defense
    @left_def_players = take_players('LD', 4)

    if @left_def_players.count < 4
      find_from_another_pos('RD', @left_def_players.count, @left_def_players)
    end

    update_teams_id(@left_def_players)

    while @left_def_players.count < 4
      @left_def_players.push('-')
    end
  end
end
