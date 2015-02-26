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

class Dog < Animal
end

class Cat < Animal
end

bruno = Dog.new('bruno',5,130)
mittens = Cat.new('Mr. Mittens',1.5,60)

puts bruno.eat
puts mittens.eat

