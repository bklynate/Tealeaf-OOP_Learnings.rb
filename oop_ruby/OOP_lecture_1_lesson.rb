#OOP in Ruby
#1. classes and objects
#2. classes contain behaviors
require 'pry'
class Dog
  @@total_number_of_dog_class = 0

  attr_accessor :name,:height,:weight

  def self.total_number_of_dogs 
    "Total number of Dog Class : #{@@total_number_of_dog_class}"
  end

  def initialize(n,h,w)
    @weight = w
    @height = h
    @name = n
    @@total_number_of_dog_class += 1
  end

  def speak
    name.capitalize + " Barks!!"
  end

  def info
    "#{name} is #{height} feet tall and weighs #{weight} pounds."
  end

  def change_info(n,h,w)
    self.weight = w
    self.height = h
    self.name = n    
  end

end
bruno = Dog.new('bruno',5,130)
puts bruno.speak

fido = Dog.new('fido',3,100)
puts fido.speak
binding.pry
# puts fido.get_name
# puts bruno.get_name