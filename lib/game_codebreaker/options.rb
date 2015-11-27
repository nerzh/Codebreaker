module GameCodebreaker
  class Options

    def self.level( level=nil )
      case level
        when "low" 
          { level: 15, hint: 2 }
        when "normal"
          { level: 10, hint: 1 }
        when "hard"
          { level: 5, hint: 0 }
        else
          { level: 15, hint: 2 }
      end
    end

  end
end