class Animal
  @@total_number_of_animal_class = 0
  attr_accessor :name,:height,:weight

  def self.total_number_of_animals 
    "Total number of Dog Class : #{@@total_number_of_animal_class}"
  end

  def initialize(n,h,w)
    @weight = w
    @height = h
    @name = n
    @@total_number_of_animal_class += 1
  end

  def speak
    name.capitalize + " speaks!!"
  end

  def info
    "#{name} is #{height} feet tall and weighs #{weight} pounds."
  end

  def change_info(n,h,w)
    self.weight = w
    self.height = h
    self.name = n    
  end

  def eat
    "#{name} is eating"
  end
end

module Swimmable
  def swim
   "I'm swimming!" 
  end
end

class Mammal < Animal
  def warm_blooded?
    true
  end
end

class Dog < Mammal
  include Swimmable

  def speak
    "#{name} is Barking!"
  end

  def eat
    "#{name} is munching"
  end

  def fetch
    "#{name} is fetching"
  end
end

class Cat < Mammal
  def speak
    "#{name} is meowing"
  end
end

bruno = Dog.new('bruno',5,130)
mittens = Cat.new('Mr. Mittens',1.5,60)

puts bruno.eat
puts mittens.eat

