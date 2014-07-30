require 'spec_helper'

describe BaseballStats::Player do
  let(:player_data) do
    { 'playerID' => 'test',
      'birthYear' => 1980,
      'nameFirst' => 'John',
      'nameLast' => 'Smith' }
  end

  describe '.find' do
    it 'returns data of player with given ID' do
      expect(BaseballStats::Player.find('test')).to be_nil
      player = BaseballStats::Player.new(player_data)
      expect(BaseballStats::Player.find('test')).to eq player
    end
  end

  describe '#full_name' do
    it 'returns full name of the player' do
      player = BaseballStats::Player.new(player_data)
      expect(player.full_name).to eq 'John Smith'
    end
  end
end
