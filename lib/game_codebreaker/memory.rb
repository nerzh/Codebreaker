require "game_codebreaker/user"

module GameCodebreaker
  class Memory

    attr_accessor :users, :path

    def initialize( path )
      @path = path
      File.exists?( path ) ? @users = load.users : @users = []
    end

    def add_games( object )
      @users.each { |user| @user = user if user.hash == object.hash }
      object.games.each { |game| @user.games << game } 
    end

    def exists?( object )
      @users.each { |user| return true if user.hash == object.hash }
      false
    end

    def get_user( object )
      @users.each { |user| @user = user if user.hash == object.hash }
      @user
    end

    def info( user )
      a = []
      a << name = user.name
      a << surname = user.surname
      a << age = user.age
      a << total_game = user.games.size
      array_win = user.games.select { |game| game.win == true }
      a << total_win = array_win.size
      a << total_losses = ( user.games.select { |game| game.win == false } ).size
      average_turns = 0 and array_win.each { |game| average_turns += game.turns }
      total_win != 0 ? a << average_turns /= total_win : a << 0
      average_level = 0 and user.games.select { |game| average_level += game.level }
      a << average_level /= total_game
    end

    def save( user )
      exists?( user ) ? ( add_games(user); user = get_user(user) ) : @users << user
      File.open(@path,'w') { |f| f.write Marshal.dump self }
    end

    def load
      return Marshal.load File.open(@path,'r').read if File.exists?( @path )
    end

  end
end