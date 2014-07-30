module BaseballStats

  class Player
    @@players = []

    attr_reader :id, :birth_year, :first_name, :last_name

    def self.find(id)
      @@players.select { |player| player.id == id }.first
    end

    def initialize(data)
      @id         = data['playerID']
      @birth_year = data['birthYear']
      @first_name = data['nameFirst']
      @last_name  = data['nameLast']
      @@players << self
    end

    def full_name
      "#{first_name} #{last_name}"
    end
  end

end
