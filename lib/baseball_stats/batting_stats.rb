require 'baseball_stats/batting_stats/player_stats'

module BaseballStats
  module BattingStats

    # Constraint of minimum of at bats for the tripple crown winner title
    TCW_MIN_AT_BATS = 400

    # Minimum number of at bats so the stats can be involved
    # in the best batting avg improvement
    BATTING_AVG_MIN_AT_BATS = 200

    class << self
      @@year_stats = {}

      def add_stats(data)
        year = data['yearID'].to_i
        @@year_stats[year] ||= []
        @@year_stats[year] << PlayerStats.new(data)
      end

      def team_slugging_percentage(team_id, year)
        puts "Team #{team_id} - slugging percentage in #{year}"
        team_stats(team_id, year).each do |player_stats|
          player = Player.find(player_stats.id)
          puts "#{player.full_name}: #{player_stats.slugging_percentage}"
        end
      end

      def tripple_crown_winner(league, year)
        puts "Tripple Crown Winner of #{league} in #{year}"
        player_id = player_with_highest_batting_avg(league, year)

        if !player_id.nil? &&
           player_id == player_with_most_home_runs(league, year) &&
           player_id == player_with_most_runs_batted_in(league, year)
          player = Player.find(player_id)
          puts player.full_name
        else
          puts 'No winner'
        end
      end

      def best_batting_avg_improvement(year)
        puts "Best batting average improvement between #{year} and #{year + 1}"
        batting_avg = player_batting_avg(year)
        next_year_batting_avg = player_batting_avg(year + 1)

        return if batting_avg.nil? || next_year_batting_avg.nil?

        # Get differences of batting averages between years
        batting_avg.each do |id, val|
          # Batting average improved
          if next_year_batting_avg[id] && next_year_batting_avg[id] > val
            batting_avg[id] = next_year_batting_avg[id] - val
          else
            batting_avg[id] = 0
          end
        end

        best_stats = batting_avg.max_by { |k,v| v }
        player = Player.find(best_stats.first)
        puts "#{player.full_name}: #{best_stats.last}"
      end

      private

      def player_with_highest_batting_avg(league, year)
        stats = league_stats(league, year)
        return nil if stats.empty?

        stats = filter_at_bats_higher_than(stats, TCW_MIN_AT_BATS)
        return nil if stats.empty?

        stats.max_by { |s| s.batting_avg }.id
      end

      def player_with_most_home_runs(league, year)
        stats = league_stats(league, year)
        return nil if stats.empty?

        stats.max_by { |s| s.home_runs }.id
      end

      def player_with_most_runs_batted_in(league, year)
        stats = league_stats(league, year)
        return nil if stats.empty?

        stats.max_by { |s| s.runs_batted_in }.id
      end

      def filter_at_bats_higher_than(stats, limit)
        stats.select { |s| s.at_bats > limit }
      end

      # Returns hash - key: player ID, val: batting average in given year
      def player_batting_avg(year)
        return unless @@year_stats[year]
        stats = filter_at_bats_higher_than(@@year_stats[year], BATTING_AVG_MIN_AT_BATS)

        batting_avg = {}
        stats.each { |s| batting_avg[s.id] = s.batting_avg }
        batting_avg
      end

      def league_stats(league, year)
        return [] unless @@year_stats[year]
        @@year_stats[year].select { |s| s.league == league }
      end

      def team_stats(team_id, year)
        return [] unless @@year_stats[year]
        @@year_stats[year].select { |s| s.team_id == team_id }
      end
    end

  end
end
