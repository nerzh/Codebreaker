require "game_codebreaker/game"

module GameCodebreaker
  class Controller

    def initialize
      @game = Game.new(level: ( Options.level(level) )[0], hint: (Options.level(level) )[1], length: length)
      @game.generate_code
    end

    def start
      @game = Game.new(level: ( Options.level(level) )[0], hint: (Options.level(level) )[1], length: length)
      @game.generate_code
    end

    def get_respond( string )
      return if @game.game_over?
      return get_hint if string == "get hint"
      skynet = Array.new(@game.code.split(//))
      human = string.split(//)
      list = [@game.code, human.join("")]
      result = @game.process( skynet, human )
      @game.game_over( result )
      @game.turns += 1; @game.history << ( list << result )
      @game
    end

  	def get_hint
      ( @game.hints << "there is no hints anymore"; @game.hints.uniq!; return ) if @game.hint == 0
      pozition = nil; old_pozitions = []

      @game.hints.each { |arr| arr.split(//).each { |str| old_pozitions << str.to_i unless str == "there is no hints anymore" } }
      @game.hint( @game.hints )
      @game.hint -= 1; @game.hints << result;
      @game
  	end

    def self.save( user_data, games )
      user = User.new( user_data[0], user_data[1], user_data[2], games )
      memory = Memory.new unless memory = Memory.load("./dump")
      memory.exists?( user ) ? ( memory.add_games(user); user = memory.get_user(user) ) : memory.users << user
      memory.save("./dump")
    end

  end
end