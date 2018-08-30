require 'nokogiri'
require 'open-uri'

class NhlParser

  def initialize(params = {})
    @proxy = params[:proxy]
  end

  def parse
    teams = parse_teams
    parse_players(teams)
  end

  private

  def parse_teams
    teams = {}
    url = 'https://www.nhlnumbers.com/team-salaries'
    doc = Nokogiri::HTML(open(url, proxy: @proxy))
    doc.css('table.stats-table').css('tbody.inner')
                                .css('tr > td[1]')
                                .css('span.long-name a')
                                .each { |link| teams[link.text.strip] = link['href'] }
    teams
  end

  def parse_players(teams)
    teams.each do |team_title, link|
      doc = Nokogiri::HTML(open(link, proxy: @proxy))
      all_players = doc.css('table.stats-table')
                       .css('tbody.first, tbody.second, tbody.third')
                       .css('tr > td[1] a[1], tr > td[3], tr > td[5], tr > td[6]')

      all_players.each_slice(4) do |player|
        Player.create!(name: player[0].text.strip,
                       link: player[0]['href'],
                       team: team_title,
                       position: player[1].text.strip,
                       nation: player[2].text.strip,
                       capacity: player[3].text.strip[1..-1].gsub!(/,/, '').to_i)
      end
    end
  end
end
