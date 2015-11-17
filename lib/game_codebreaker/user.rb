module GameCodebreaker
	class User

	  attr_accessor :name, :surname, :age, :games

	  def initialize( name, surname, age, games=[] )
	    @name, @surname, @age, @games = name, surname, age, games 
	  end

	  def hash
	    [@name, @surname].hash
	  end

	end
end