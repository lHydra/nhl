require 'rails_helper'
require 'best_team'

describe 'BestTeam' do
  let(:players) { BestTeam.new(nation: 'Russia') }

  context 'when there are players for all positions' do
    before do
      create_list(:player, 6, position: 'LW', capacity: rand(1..3000000))
      create_list(:player, 7, position: 'C', capacity: rand(1..3000000))
      create_list(:player, 8, position: 'RW', capacity: rand(1..3000000))
      create_list(:player, 7, position: 'LD', capacity: rand(1..3000000))
      create_list(:player, 6, position: 'RD', capacity: rand(1..3000000))
    end

    it 'returns best 4 left forward players for nation team' do
      lw = Player.where(position: 'LW')

      expect(players.lw_players).to eq(lw.order(capacity: :desc).take(4))
    end

    it 'returns best 4 center players for nation team' do
      c = Player.where(position: 'C')

      expect(players.c_players).to eq(c.order(capacity: :desc).take(4))
    end

    it 'returns best right forward players for nation team' do
      rw = Player.where(position: 'RW')

      expect(players.rw_players).to eq(rw.order(capacity: :desc).take(4))
    end

    it 'returns best left defense players for nation team' do
      ld = Player.where(position: 'LD')

      expect(players.ld_players).to eq(ld.order(capacity: :desc).take(4))
    end

      it 'returns best left forward players for nation team' do
      rd = Player.where(position: 'RD')

      expect(players.rd_players).to eq(rd.order(capacity: :desc).take(4))
    end
  end

  context 'when there are not players for all positions' do
    before do
      create_list(:player, 5, position: 'LW', capacity: rand(1..3000000))
      create_list(:player, 3, position: 'C', capacity: rand(1..3000000))
      create_list(:player, 5, position: 'RW', capacity: rand(1..3000000))
      create_list(:player, 3, position: 'LD', capacity: rand(1..3000000))
      create_list(:player, 4, position: 'RD', capacity: rand(1..3000000))
    end

    it 'has a dash if no one player on position' do
      expect(players.ld_players.last).to eq('-')
    end

    it 'has a player from another position with a higher capacity' do
      lw = Player.where(position: 'LW').order(capacity: :desc).last
      rw = Player.where(position: 'RW').order(capacity: :desc).last

      c = rw.capacity > lw.capacity ? rw : lw
      expect(players.c_players.last.position).to eq(c.position)
      expect(players.c_players.last) == c
    end
  end
end
