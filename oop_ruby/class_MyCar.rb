require 'pry'

class MyCar

  def initialize(y,c,m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "> You push the gas and accelerate #{number} mph."
  end

  def break(number)
    @current_speed -= number
    puts "> You step on the gas decelerate #{number} mph."
  end

  def turn_off
    @current_speed = 0
    puts "> Let's park it up."
  end

  def current_speed
    puts "Currently cruising along at #{@current_speed} mph."
  end
    
end

binding.pry