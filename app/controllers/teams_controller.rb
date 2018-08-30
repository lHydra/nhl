class TeamsController < ApplicationController
  def index
    @nations = Player.pluck(:nation).uniq
  end

  def show
    @nation = params[:nation][:name]

    @team_players = BestTeam.new(nation: @nation)
    @team_players.create_best_team
  end
end
