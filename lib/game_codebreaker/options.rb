module GameCodebreaker
  class Options

    def self.level( level=nil )
      case level
        when "low" 
          [ 15, 2 ]
        when "normal"
          [ 10, 1 ]
        when "hard"
          [ 5, 0 ]
        else
          [ 15, 2 ]
      end
    end

  end
end