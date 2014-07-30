require 'spec_helper'

describe BaseballStats::BattingStats do
  describe '.add_stats' do
    it 'stores batting data into hash'
  end

  describe '.team_slugging_percentage' do
    it 'shows slugging percentage stats of each player in the team'
  end

  describe '.tripple_crown_winner' do
    it 'shows the player with this title in specied year'
  end

  describe '.best_batting_avg_improvement' do
    it 'shows player with the best batting improvement'
  end
end
