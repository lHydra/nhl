class TeamsController < ApplicationController
  def index
    @nations = Player.pluck(:nation).uniq
  end

  def show
    @nation = params[:nation][:name]

    @team_players = BestTeam.new(nation: @nation)
  end
end
