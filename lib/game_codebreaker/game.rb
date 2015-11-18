require "game_codebreaker/options"
require "game_codebreaker/memory"
require "game_codebreaker/user"

module GameCodebreaker
  class Game

    JUST_A_MAGIC_NUMBER = 10

    attr_accessor :code, :length, :level, :turns, :history, :hint, :win, :hints, :game_over

    def initialize( code: "", length: 4, level: (Options.level)[0], turns: 0, history: [],
                    hint: (Options.level)[1], hinted: 0, win: false, game_over: false,
                    hints: [] )
      @code, @length     = code, length
      @level, @turns     = level, turns
      @history, @hint    = history, hint
      @hinted, @win      = hinted, win
      @hints, @game_over = hints, game_over
    end

    def generate_code
      @length.times{ @code << rand(1..6).to_s }
    end

    def process( skynet, human )
      result = ""
      @length.times do |i|
        if skynet[i] == human[i]
          result += "+"
          skynet[i], human[i] = nil, nil
        end
      end
      skynet.compact!; human.compact!;
      human.each { |val| result += "-" if skynet.include?( val ) }
      result
    end

    def respond( string )
      return if game_over?
      get_hint and return if string == "get hint"
      skynet = Array.new(@code.split(//))
      human = string.split(//)
      list = [@code, human.join("")]
      result = process( skynet, human )
      check_game( result )
      @turns += 1; @history << ( list << result )
    end

    def get_hint 
      ( @hints << "there is no hints anymore"; @hints.uniq!; return ) if @hint == 0
      pozition = nil; old_pozitions = []
      @hints.each do |str|
        str.split(//).each_with_index { |word, index| old_pozitions << index unless word.to_i == 0 } 
      end
      ( @length*JUST_A_MAGIC_NUMBER ).times { pozition = rand( @length ); break unless old_pozitions.include?( pozition ) }
      result = ""
      @length.times { |i| pozition == i ? result << @code.to_s[i] : result << "-" }
      @hint -= 1; @hints << result;
    end

    def check_game( string )
      @game_over = true if @turns == @level
      (@win = true; @game_over = true) if string.count("+") == @length
    end

    def game_over?
      @game_over
    end

    def win?
      @win
    end

    def self.save( user_data, games )
      user = User.new( user_data[0], user_data[1], user_data[2], games )
      memory = Memory.new unless memory = Memory.load("./dump")
      memory.exists?( user ) ? ( memory.add_games(user); user = memory.get_user(user) ) : memory.users << user
      memory.save("./dump")
      user
    end

  end
end


















