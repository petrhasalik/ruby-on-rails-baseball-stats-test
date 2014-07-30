module BaseballStats
  module BattingStats

    class PlayerStats
      attr_reader :id,
        :league,
        :team_id,
        :at_bats,
        :hits,
        :doubles,
        :triples,
        :home_runs,
        :runs_batted_in

      def initialize(data)
        @id             = data['playerID']
        @league         = data['league']
        @team_id        = data['teamID']
        @at_bats        = data['AB'].to_i
        @hits           = data['H'].to_i
        @doubles        = data['2B'].to_i
        @triples        = data['3B'].to_i
        @home_runs      = data['HR'].to_i
        @runs_batted_in = data['RBI'].to_i
      end

      def batting_avg
        # Cannot divide by zero
        if at_bats != 0
          @batting_avg ||= hits.to_f / at_bats
        else
          0
        end
      end

      def slugging_percentage
        # Cannot divide by zero
        if at_bats != 0
          @slugging_percentage ||= ((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)).to_f / at_bats
        end
      end
    end

  end
end
