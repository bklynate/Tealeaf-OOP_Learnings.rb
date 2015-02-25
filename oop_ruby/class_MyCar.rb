require 'pry'

class MyCar
  attr_accessor :color ,:model # solution to question 2 
  attr_reader  :year # solution to question 2 

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
    puts "> Currently cruising along at #{@current_speed} mph."
  end
    
  def spray_paint(color) # Solution to question 3
    self.color = color
    puts "> Color of car has been changed to #{color}"
  end

  def self.gas_mileage(gallons,miles)
    puts "> #{m/g}miles per gallon of gas"
  end

  def to_s
    puts "Car Model: #{@model} | Year: #{year} | Color: #{color}"
  end
end

audiRS4 = MyCar.new(2015,'Black','Audi RS4')
binding.pry
audiRS4.speed_up(35)
audiRS4.current_speed
audiRS4.speed_up(42)
audiRS4.current_speed

