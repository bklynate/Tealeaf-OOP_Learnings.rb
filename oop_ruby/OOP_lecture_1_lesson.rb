#OOP in Ruby
#1. classes and objects
#2. classes contain behaviors

class Dog
  def initialize(n,h,w)
    @weight = w
    @height = h
    @name = n
  end

  def speak
    @name + "Bark!!"
  end

  def get_name
    @name 
  end

  def set_name=(new_name)
    @name = new_name    
  end
  
  def info
    "#{@name} is #{@height} feet tall and weighs #{@weight} pounds."
  end
end

bruno = Dog.new('bruno')
puts bruno.speak

fido = Dog.new('fido')
puts fido.speak

puts fido.get_name
puts bruno.get_name