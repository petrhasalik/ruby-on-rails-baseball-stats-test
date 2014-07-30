require 'csv'
require 'baseball_stats/player'
require 'baseball_stats/batting_stats'

module BaseballStats

  PLAYERS_CSV = 'csv/players.csv'
  BATTING_CSV = 'csv/batting.csv'

  class << self
    def import_data
      import_players
      import_batting_data
      import_pitching_data
    end

    private

    def import_players
      begin
        CSV.foreach(PLAYERS_CSV, headers: :first_row) do |row|
          next unless row['playerID']
          Player.new(row)
        end
      rescue CSV::MalformedCSVError => err
        puts err.message
      end
    end

    def import_batting_data
      begin
        CSV.foreach(BATTING_CSV, headers: :first_row) do |row|
          BattingStats.add_stats(row)
        end
      rescue CSV::MalformedCSVError => err
        puts BATTING_CSV
        puts err.message
      end
    end

    # TODO Pitching data not available yet
    def import_pitching_data
    end
  end

end
